-module(sort).
-export([qsort/1,mergesort/1,insertion/1]).

qsort([]) ->
	[];
qsort([X|Xs]) ->
	qsort([Y || Y<-Xs, Y =< X]) ++ [X] ++ qsort([Y || Y<-Xs, Y > X]).

insertion(L) -> 
	lists:foldl(fun insert/2, [], L).
 
insert(X,[]) -> 
	[X];
insert(X,L=[H|_]) when X =< H -> 
	[X|L];
insert(X,[H|T]) -> 
	[H|insert(X, T)].

mergesort([]) -> 
	[];
mergesort([E]) -> 
	[E];
mergesort(L) ->
  	{A, B} = lists:split(trunc(length(L)/2), L),
  	merge(mergesort(A), mergesort(B)).

merge(A, []) -> 
	A;
merge([], B) -> 
	B;
merge([Ha|Ta], [Hb|Tb]) ->
  	if
    	Ha < Hb -> [Ha | merge(Ta, [Hb|Tb])];
    	true -> [Hb | merge([Ha|Ta], Tb)]
  	end.


%For each loop in Erlang.
%1> Printer = fun(E) -> io:format("E: ~p~n", [E]) end.
%#Fun<erl_eval.6.52032458>
%2> lists:foreach(Printer,[1,2,3,4,5,6]).
%E: 1
%E: 2
%E: 3
%E: 4
%E: 5
%E: 6
%ok
%For each loop printing out odd numbers in list.
%4> lists:foreach(Printer,lists:filter(Odd,[1,2,3,4,5])).
