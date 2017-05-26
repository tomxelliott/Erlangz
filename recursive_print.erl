-module(solution).
-export([main/0,repeat/1]).

main() ->

    { ok, [N]} = io:fread("", "~d"),
    true,
    repeat(N).


repeat(Times) when Times >= 0 -> repeat(0, Times).

repeat(Times, Times) -> done;
repeat(N, Times) ->
    H = "Hello World",
    io:format("~s~n", [H]),
    repeat(N + 1, Times).
