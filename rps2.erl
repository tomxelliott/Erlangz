-module (rps2).
-export ([]).

play_two(StrategyL,StrategyR,N) ->
	play_two(StrategyL,StrategyR, [], [], N).

play_two(_,_,PlaysL,PlaysR,0) ->
	io:format("Overakk result ... ");

% N is the number of goes left...
play_two(StrategyL,StrategyR,PlaysL,PlaysR,N) ->
	PlayL = StrategyL(PlaysR),
	PlayR = StrategyR(PlaysL),
	Result = result(PlayL,PlayR),
	io:format("Result: ~p~n", [Result]),
	play_two(StrategyL,StrategyR,[PlayL|PlaysL], [PlayR|PlaysR],N-1).
