-module(second).
-export([mult/2,square/1,hypotenuse/2,areaOfTriangle/2]).

mult(X,Y) ->
    X*Y.

square(X) ->
	mult(X,X).

hypotenuse(X,Y) ->
	square(X) + square(Y).

areaOfTriangle(X,Y) ->
	X*Y/2.
