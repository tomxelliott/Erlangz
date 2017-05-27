-module(rockpaper).
-export([tournament/2]).

% A based score depends on cheating.
a_lose_if_b(A,B) ->
    B_cheat = not lists:member(B, [paper, rock, scissors]),
    A_cheat = not lists:member(A, [paper, rock, scissors]),
    case {A_cheat, B_cheat} of
        {true, true} -> 0;
        {_, true} -> 1;
        _ -> -1
    end.

% A based score.
% The win/lose system is symmetric, we only need win cases for A.
result({A,A},Score) -> 0 + Score;
result({A,B},Score) ->
    Score + case {A,B} of
        {paper,rock} -> 1;
        {rock,scissors} -> 1;
        {scissors,paper} -> 1;
        _ -> a_lose_if_b(A,B)
    end.

tournament(Xs,Ys) ->
    lists:foldl(fun result/2, 0, lists:zip(Xs,Ys)).
