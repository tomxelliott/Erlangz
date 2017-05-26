-module(concurrency_ex).
-export([start/0]).

start() -> 
  spawn(fun() -> loop() end).

loop() ->
  receive
    Any ->
      io:format("~nI got the message: ~p~n",[Any]),
      loop()
  end.

%1> c(concurrency_ex).
%{ok,concurrency_ex}
%2> Pid = concurrency_ex:start().
%<0.38.0>
%3> Pid ! something.
%something
%I got the message: something

%4> Pid ! [something,else].
%[something,else]
%I got the message: [something,else]
