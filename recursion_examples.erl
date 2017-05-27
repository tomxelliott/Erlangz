-module(recursion_examples).
-export([fibo/1, pieces_a/1, pieces_b/1, run_tests/0]).

% Public

fibo(N) -> fibo([0, 1], N).

pieces_a(N) -> cut_a(0, 0, N).

pieces_b(N) -> cut_b([0, 1], 0, N).

% Private

fibo(List, 0) -> List;
fibo(List, Iter) ->
  Sum = aggregate_last_two(List),
  fibo(List ++ [Sum], Iter - 1).

cut_a(Acc, _, 0) -> Acc;
cut_a(0, 0, Max) -> cut_a(1, 1, Max);
cut_a(Acc, Iter, Max) -> cut_a(Iter + Acc, Iter + 1, Max - 1).

cut_b(List, _, 0) -> aggregate_last_two(List);
cut_b(List, Iter, Max) ->
  Pieces = aggregate_last_two(List),
  cut_b([Pieces, Iter + 1], Iter + 1, Max - 1).

aggregate_last_two(List) ->
  Tail = lists:nthtail(length(List) - 2, List),
  lists:sum(Tail).

% Tests

run_tests() ->
  case fibo(4) of
    [0, 1, 1, 2, 3, 5] -> io:format("fibo(4) works fine\n");
    _ -> io:format("fibo(4) works wrong\n")
  end,

  case pieces_a(4) of
    11 -> io:format("pieces_a(4) works fine\n");
    _ -> io:format("pieces_a(4) works wrong\n")
  end,

  case pieces_b(4) of
    11 -> io:format("pieces_b(4) works fine\n");
    _ -> io:format("pieces_b(4) works wrong\n")
  end.
