-module(fib).

-export([main/0]).

main() ->
    { ok, [X]} = io:fread("", "~d"),
    Res = fib(X),
    io:format("~p~n", [Res]).


fib(0) ->
    0;
fib(1) ->
    1;
fib(2) ->
    1;
fib(3) ->
    1;
fib(4) ->
    2;
fib(5) ->
    3;
fib(N) ->
    fib(N-1) + fib(N-2).
