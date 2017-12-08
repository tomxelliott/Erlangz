-module(bools).
-export([b_not/1, b_and/2, b_nand/2]).

b_not(false) ->
	    true;
b_not(true) ->
	    false.

b_and(true, true) ->
	    true;
b_and(false, true) ->
	    false;
b_and(true, false) ->
	    false;
b_and(false, false) ->
	    false.

b_nand(true, true) ->
	     b_and(b_not(true), b_not(true));
b_nand(false, true) ->
	     b_and(b_not(false), b_not(true));
b_nand(true, false) ->
	     b_and(b_not(true), b_not(false));
b_nand(false, false) ->
	      b_and(b_not(false), b_not(false)).
