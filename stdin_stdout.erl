-module(stdin_stdout).
-export([main/0]).
addme(A, B) ->
    A + B.
main() -> 
    {ok, [A, B]} = io:fread("", "~d~d"),
    Res = addme(A,B),
    io:format("~p~n",[Res]).
