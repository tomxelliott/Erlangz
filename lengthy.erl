-module(lengthy).
-export([main/0,lengthy/1,factorial/1]).

main() ->
    { ok, [N]} = io:fread("", "~d"),
    true,
    lengthy(N).

lengthy([]) ->
    0;
lengthy([_|T]) ->
    1 + lengthy(T).
    
factorial(0) -> 
	1;
factorial(N) ->
	N * factorial(N - 1).
