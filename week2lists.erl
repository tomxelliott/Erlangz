-module(week2lists).
-import(lists, [nth/2, sort/1]).
-export([head/1,tail/1,second/1,sum/1,sum/2,product/1]).
-export([all_areas/1,total_area/1,area/1,maximum/1,t_product/2,t_maximum/2]).
-export([median/1,circles/1,double/1,increment/1,decrement/1, even/1]).

head([X|_Xs]) ->
	X.
tail([_X|Xs]) ->
	Xs.

second(Xs) ->
	head(tail(Xs)).

sum(Xs) -> 
	sum(Xs, 0).
sum([],S) ->
	S;
sum([X|Xs],S) ->
	sum(Xs, X+S).

product([]) ->
	1;
product([X|Xs]) when is_number(X) ->
	X * product(Xs).

t_product([], P) ->
	P;
t_product([X|Xs], P) when is_number(X) ->
	t_product(Xs, X * P).

maximum([X]) ->
	X;
maximum([X|Xs]) ->
	max(X, maximum(Xs)).

t_maximum([], Max) ->
	Max;
t_maximum([X|Xs], Max) ->
	t_maximum(Xs, max(Max, X)).

area({circle, {X,Y}, R}) ->
	math:pi()*R*R;
area({rectangle, {X,Y},H, W}) ->
	H*W.

total_area(Shapes) ->
	AllAreas = all_areas(Shapes), sum(AllAreas).

all_areas([]) ->
	[];
all_areas([X|Xs]) ->
	[area(X) | all_areas(Xs)].
% example input: [{rectangle, {5,4},3, 2}, {circle, {1,2}, 2}, {rectangle, {3,2},10, 8}]

circles([])     -> [] ; 

circles( [X | Xs] ) ->
    case X of % is the head of the list a circle?
	{circle,{_,_},_}=C ->
	    [ C | circles(Xs) ];
	_ -> %otherwise call circles with just tail.
	    circles(Xs)
end.

median(Unsorted) ->
    Sorted = sort(Unsorted),
    Length = length(Sorted),
    Mid = Length div 2,
    Rem = Length rem 2,
    (nth(Mid+Rem, Sorted) + nth(Mid+1, Sorted)) / 2.

double([]) ->
	[];
double([H|T]) ->
	[2*H|double(T)].

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].
 
decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

even(L) ->
	lists:reverse(even(L,[])).
even([], Acc) ->
	Acc;
even([H|T], Acc) when H rem 2 == 0 ->
	even(T, [H|Acc]);
even([_|T], Acc) ->
	even(T, Acc).

