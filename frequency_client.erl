-module(frequency_client).
-export([stage_test/0, client/0, hardened_client/0, hardened_client_loop/0]).

stage_test() ->
  frequency:start(),
  Client1 = spawn(?MODULE, client, []),
  Client2 = spawn(?MODULE, client, []),
  Client3 = spawn(?MODULE, hardened_client, []),
  Client4 = spawn(?MODULE, hardened_client, []),
  Client1 ! allocate,
  Client2 ! allocate,
  Client3 ! allocate,
  Client4 ! allocate,
  {Client1, Client2, Client3, Client4}.

client() ->
  receive
    allocate ->
      frequency ! {request, self(), allocate},
      client();
    {reply,X} ->
      io:format("~p got ~p", [self(), X]),
      client()
  end.

hardened_client() ->
  process_flag(trap_exit, true),
  hardened_client_loop().

hardened_client_loop() ->
  receive
    allocate ->
      frequency ! {request, self(), allocate},
      hardened_client_loop();
    {reply,X} ->
      io:format("~p got ~p", [self(), X]),
      hardened_client_loop();
    {'EXIT', Pid, Reason} ->
      io:format("~p got EXIT from ~p reason ~p", [self(), Pid, Reason]),
      hardened_client_loop()
  end.
