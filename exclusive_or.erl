-module(exclusive_or).

-export([xOr/2,exOr/2,xOrAlt/2,maxThree/3,howManyEqual/3,fac/1]).

xOr(true,false) ->
	true;
xOr(false,true) ->
	true;
xOr(_,_) ->
	false.

exOr(true,X) ->
	not(X);
exOr(false,X) ->
	X.

xOrAlt(X,X) ->
	false;
xOrAlt(_,_) ->
	true.

% max of 3 values 
maxThree(X,Y,Z) -> 
max(max(X,Y), Z).

% how many values are same 
howManyEqual(X, X, X) -> 
3; 
howManyEqual(X, X, _Y) -> 
2; 
howManyEqual(X, _Y, X) -> 
2; 
howManyEqual(_Y, X, X) -> 
2; 
howManyEqual(_X, _Y, _Z) -> 
0.


fac(0) -> 
	1;
fac(N) when N>0 -> 
	fac(N-1)*N.
