-module(mail).
-export([receiver1/0, receiver2/0, receiver3/0, sequence/0]).

% receiver1/0 receives a message and then prints a string containing it.

receiver1() ->
    timer:sleep(400),
    receive
        Msg ->
            io:format("message: ~w~n", [{ok,Msg}]),
            receiver1()
    end.

% receiver2/0 receives a message and then prints a string containing it. If the
% message is the atom stop, receiver2/0 prints the output and then terminates.

receiver2() ->
    timer:sleep(400),
    receive
        stop ->
            io:format("message: ~w~n", [{ok,stop}]);
        Msg ->
            io:format("message: ~w~n", [{ok,Msg}]),
            receiver2()
    end.

% receiver3/0 receives a message and then prints a string containing it. If the
% message is the atom stop, receiver3/0 prints the output and then terminates.

receiver3() ->
    timer:sleep(400),
    receive
        Msg ->
            case Msg of
                stop ->
                    io:format("message: ~w~n", [{ok,Msg}]);
                _ ->
                    io:format("message: ~w~n", [{ok,Msg}]),
                    receiver3()
            end
    end.

% sequence/0 responds to messages in a particular order, irrespective of the
% order in which they arrive in the mailbox.

sequence() ->
    receive
        {first, FirstString} ->
            io:format("message: ~w~n", [{first, FirstString}]),
            sequence();
        {second, SecondString} ->
            receive
                {first, FirstString} ->
                    io:format("message: ~w~n", [{first, FirstString}])
            end,
            io:format("message: ~w~n", [{second, SecondString}]),
            sequence()
    end.
