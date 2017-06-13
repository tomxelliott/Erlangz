-module(gcd).
-export([main/0]).

main() ->
    {ok, [A, B]} = io:fread("", "~d~d"),
    Res = gcd(A,B),
    io:format("~p~n",[Res]).
 
gcd(A, 0) -> A;
 
gcd(A, B) -> 
    gcd(B, A rem B).
