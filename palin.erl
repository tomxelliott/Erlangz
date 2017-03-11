-module(palin).
-export([palindrome/1,palin/1]).

palindrome(Xs) ->
	palin(nocaps(nopunct(Xs))).

nopunct([]) ->
    [];
nopunct([X|Xs]) ->
    case lists:member(X,".,\ ;:\t\n\'\"") of
	true ->
	    nopunct(Xs);
	false ->
	    [ X | nopunct(Xs) ]
    end.

nocaps([]) ->
	[];
nocaps([X|Xs]) ->
	[ nocap(X) | nocap(Xs) ].

nocap(X) ->
	case $A =< X andalso X =< $Z of
			true ->
				X+32;
			false ->
				X
	end.

%literal palindrome ------
palin(Xs) ->
	Xs == reverse(Xs).

reverse(Xs) ->
	shunt(Xs,[]).

shunt([], Ys) ->
	Ys;
shunt([X|Xs],Ys) ->
	shunt(Xs,[X|Ys]).
%----------------------------

