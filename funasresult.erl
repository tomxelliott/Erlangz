-module (funasresult).
-export ([function/arity]).

% "Partially Applied" functions
% Curried representation
add(X) ->
	fun(Y) -> X+Y end.

addOneToAll(Xs) ->
	lists:map(add(1), Xs).

	addToAll(N, Xs) ->
		lists:map(add(N), Xs).

% -------------------------------------------
% funtion composition to define functions
% both argument and the result are functions.
% -------------------------------------------
compose(F,G) ->
	fun(X) -> G(F(X)) end.

iterate(0) ->
	fun(_F) ->
			fun id/1 end;

iterate(N) ->
	fun(F) ->
		compose(F,(iterate(N-1))(F)) end.
