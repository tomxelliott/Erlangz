-module(numbers).
-export([square/1]).

square(0) ->
	0*0;
square(N) ->
	N*N.
