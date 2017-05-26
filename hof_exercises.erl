-module(hof_exercises).
-export([doubleAll/1,evens/1,product/1,zip_with/3,zip/3]).

doubleAll(Xs) ->
	lists:map(fun(X) -> 2*X end, Xs).

evens(Xs) ->
	lists:filter(fun(X) -> X rem 2 == 0 end, Xs).

product(Xs) ->
	lists:foldr(fun(X,Acc) -> Acc * X end, 1, Xs).

zip_with(_F,_,[]) ->
	[];
zip_with(_F,[],_) ->
	[];
zip_with(F,[X|Xs],[Y|Ys]) ->
	[F(X,Y) | zip_with(F,Xs,Ys)].
%call this function with:
%  hof_exercises:zip_with(fun(X,Y) -> max(X,Y) end, [1,2,3,4], [0,5,4,3]).
%this function takes the largest out of the two lists at each index and adds it to the list.

zip(_F,_,[]) ->
	[];
zip(_F,[],_) ->
	[];
zip(F, [X|Xs], [Y|Ys]) ->
	[F(X,Y) | zip(F,Xs,Ys)].
%hof_exercises:zip(fun(X,Y) ->{X,Y} end, [1,2,3,4], [0,5,4,3]).

