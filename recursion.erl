-module(recursion).

-export([fib/1,pieces/1,threedim_pieces/1,pieces_any_dimension/2,loop/1]).

fib(0) -> 
	0;
fib(1) -> 
	1;
fib(2) ->
	1;
fib(N) when N>2 -> 
	fib(N-1) + fib(N-2).

pieces(0) ->
	1;
pieces(N) ->
	N + pieces(N-1).

threedim_pieces(0) ->
	1;
threedim_pieces(N) when N>0 ->
	threedim_pieces(N-1) + pieces(N-1).

pieces_any_dimension(0,_) ->
	1;
pieces_any_dimension(N,2) when N>0 ->
	pieces(N);
pieces_any_dimension(N,D) when N>0, D>2 ->
	pieces_any_dimension(N-1,D) + pieces_any_dimension(N-1,D-1).

loop(0) ->
	io:format("bye~n");
loop(N) when N>0 ->
	io:format("~p~n",[N]),
	loop(N-1);
loop(N) ->
	io:format("bye~n").
