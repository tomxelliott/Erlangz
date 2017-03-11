-module(week2pt2).
-export([take/2,take_alt/2,nub/1,bun/1]).

-spec take(integer(),[T]) -> [T].

take(0, _Xs) ->
	[];
take(_N, []) ->
	[];
take(N, [X|Xs]) when N>0 ->
	[X|take(N-1, Xs)].

% The problem with this function is that the N variable cannot exceed the word(s).
take_alt(0, _Xs) ->
	[];
take_alt(N,Xs) when N>0 ->
	{Front,_Back} = lists:split(N,Xs), Front.


nub([]) ->
	[];
nub([X|Xs]) ->
	[X|nub(removeAll(X,Xs))].

removeAll(_X, []) ->
	[];
removeAll(X,[X|Xs]) ->
	removeAll(X, Xs);
removeAll(X,[Y|Xs]) ->
	[Y | removeAll(X,Xs)].

bun([]) ->
	[];
bun([X|Xs]) ->
	case member(X,Xs) of
		true ->
			bun(Xs);
		false ->
			[X|bun(Xs)]
	end.

member(_,[]) ->
	false;
member(X,[X|_Xs]) ->
	true;
member(X,[_Y|Xs]) ->
	member(X,Xs).
