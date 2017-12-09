-module(listy).
-export([firsty/1, lasty/1, listy/1, summer/1, list_summer/1]).
-export([membery/2, checker/1, oddevens/1, altoddevens/1, factorial/1, altfactorial/1]).

firsty([]) -> [];
firsty([H|_]) -> H.

lasty([X]) -> X;
lasty([_|Xs]) ->
	lasty(Xs).

listy([]) -> [];
listy([X|Xs]) ->
	io:fwrite("~p, ", [X]), listy(Xs).

summer(0) -> 0;
summer(X) ->
	X + summer(X-1).

list_summer([]) -> 0;
list_summer([X|Xs]) ->
	X + list_summer(Xs).


membery(X, L) ->
	case lists:member(X, L) of
		true -> ok;
       	false -> {error, unknown_element}
	end.

checker(X) ->
	if
		X >= 18 -> 'you are old enough';
		X < 18 -> 'you are not old enough!'
	end.

oddevens(X) ->
	if
		X rem 2 == 0  -> 'even stevens';
		X rem 2 == 1 -> 'bill oddie'
	end.

altoddevens(X) ->
	case X rem 2 of
		1 -> odd;
		0 -> even
	end.

factorial(0) -> 1;
factorial(N) ->
	N * factorial(N-1).

altfactorial(N) when N > 0 ->
	N * factorial(N-1);
altfactorial(0) -> 1.

