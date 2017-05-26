-module(frequency).
-export([start/0,allocate/0,deallocate/1,stop/0]).
-export([init/0, clear/0]).

%% These are the start functions used to create and
%% initialize the server.

start() ->
    register(frequency,
	     spawn(frequency, init, [])).

init() ->
  process_flag(trap_exit, true),
  Frequencies = {get_frequencies(), []},
  loop(Frequencies).

% Hard Coded
get_frequencies() -> [10,11,12,13,14,15].

%% The Main Loop
%% Freq = spawn(frequency, init, [])).
%% Freq ! {request, self(), allocate}.
%% receive {reply, Reply} -> Reply end.

loop(Frequencies) ->
  receive
    {request, Pid, allocate} ->
      timer:sleep(4000),
      {NewFrequencies, Reply} = allocate(Frequencies, Pid),
      Pid ! {reply, Reply},
      loop(NewFrequencies);
    {request, Pid , {deallocate, Freq}} ->
      timer:sleep(4000),
      NewFrequencies = deallocate(Frequencies, Freq),
      Pid ! {reply, ok},
      loop(NewFrequencies);
    {'EXIT', Pid, _Reason} ->
      NewFrequencies = exited(Frequencies, Pid),
      loop(NewFrequencies);
    {request, Pid, stop} ->
      timer:sleep(4000),
      Pid ! {reply, stopped}
  end.

%% Functional interface
%% frequency:allocate(). 

allocate() -> 
    frequency ! {request, self(), allocate},
    receive 
	    {reply, Reply} -> Reply
    after 10000 ->
      {reply, {error,timeout}}
    end.

%% eg. frequency:deallocate(11).

deallocate(Freq) -> 
    frequency ! {request, self(), {deallocate, Freq}},
    receive 
	    {reply, Reply} -> Reply
    after 10000 ->
      {reply, {error,timeout}}
    end.

exited({Free, Allocated}, Pid) ->
  case lists:keysearch(Pid,2,Allocated) of
    {value,{Freq,Pid}} ->
      NewAllocated = lists:keydelete(Freq,1,Allocated),
      {[Freq|Free],NewAllocated};
    false ->
      {Free,Allocated}
  end.

stop() -> 
    frequency ! {request, self(), stop},
    receive 
	    {reply, Reply} -> Reply
    after 10000 ->
      {reply, {error,timeout}}
    end.


%% The Internal Help Functions used to allocate and
%% deallocate frequencies.

allocate({[], Allocated}, _Pid) ->
  {{[], Allocated}, {error, no_frequency}};
allocate({[Freq|Free], Allocated}, Pid) ->
  link(Pid),
  {{Free, [{Freq, Pid}|Allocated]}, {ok, Freq}}.

deallocate({Free, Allocated}, Freq) ->
  {value,{Freq,Pid}} = lists:keysearch(Freq,1,Allocated),
  unlink(Pid),
  NewAllocated=lists:keydelete(Freq, 1, Allocated),
  {[Freq|Free],  NewAllocated}.

% If after 0 ms there are no messages to clear, timeout message printed out.
clear() -> 
  receive 
    Msg -> io:format("Clearing ~p~n~n",[Msg]), 
    clear() 
  after 0 -> 
    ok 
  end.

