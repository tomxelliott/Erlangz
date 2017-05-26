-module(lengthy).
-export([main/0,lengthy/1]).

main() ->
    { ok, [N]} = io:fread("", "~d"),
    true,
    lengthy(N).

lengthy([]) ->
    0;
lengthy([_|T]) ->
    1 + lengthy(T).
