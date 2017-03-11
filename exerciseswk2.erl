-module(exerciseswk2).
-export([concat/1,memberOfList/2,qsort/1,mergesort/1,insertion/1,permutations/1]).

concat([]) ->
	[];
concat([X,Xs]) ->
	join(X,Xs).

join([],[]) ->
	[];
join(X,Xs) ->
	lists:concat([X,Xs]).

memberOfList(X,Y) ->
	lists:member(X,Y).

qsort([]) ->
	[];
qsort([X|Xs]) ->
	qsort([Y || Y<-Xs, Y =< X]) ++ [X] ++ qsort([Y || Y<-Xs, Y > X]).

insertion(L) -> lists:foldl(fun insert/2, [], L).
 
insert(X,[]) -> [X];
insert(X,L=[H|_]) when X =< H -> [X|L];
insert(X,[H|T]) -> [H|insert(X, T)].


mergesort([]) -> [];
mergesort([E]) -> [E];
mergesort(L) ->
  {A, B} = lists:split(trunc(length(L)/2), L),
  merge(mergesort(A), mergesort(B)).

merge(A, []) -> A;
merge([], B) -> B;
merge([Ha|Ta], [Hb|Tb]) ->
  if
    Ha < Hb -> [Ha | merge(Ta, [Hb|Tb])];
    true -> [Hb | merge([Ha|Ta], Tb)]
  end.

permutations([]) -> 
	[[]];
permutations([X|Xs]) ->
    lists:flatmap(
        fun (Perms) -> permute(X, Perms) end,
        permutations(Xs)
    ).


-spec permute(T, [T]) -> 
	[[T]].
permute(X, []) -> 
	[[X]];
permute(X, List=[L|Ls]) ->
	[[X|List] | lists:map(
        fun (A) -> [L|A] end,
        permute(X, Ls))].
