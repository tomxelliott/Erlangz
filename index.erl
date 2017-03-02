-module(index).
-export([get_file_contents/1, show_file_contents/1]).

% Used to read a file into a list of lines.

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.
get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Lines = get_all_lines(File,[]),
    Entry = lines_to_entry(lists:reverse(Lines)),
    lists:keysort(1, Entry).

% Auxiliary function for get_file_contents.
% Not exported.
get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                get_all_lines(File,[Strip|Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.
show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
 show_file_contents([]) ->
    ok.


% Construct data model from a list of lines.
lines_to_entry(L) -> 
    lines_to_entry(L, [], 0).
lines_to_entry([],Es,_) -> 
    Es;
lines_to_entry([L|Ls],Es,Lth) ->
    case L of
        [] -> lines_to_entry(Ls, Es, Lth + 1);
        _ ->
            NewEs = make_entry(line_to_words(L), Es, Lth + 1),
            lines_to_entry(Ls, NewEs, Lth + 1)
    end.

% Sanitize a line and break it into words by blank space delimeter.
line_to_words([]) -> 
    [];
line_to_words(S) ->
    CleanS = re:replace(S, "[^A-Za-z\s]", "", [global,{return,list}]),
    LowerS = string:tokens(string:to_lower(CleanS), " "),
    lists:filter(fun(X) -> length(X) > 2 end, LowerS).


make_entry([],Es,_) -> 
    Es;
make_entry([W|Ws],Es,Lth) ->
    NewEs = update_entry(W, Es, Lth),
    make_entry(Ws, NewEs, Lth).

update_entry(W,[],Lth) ->
    [{W, [{Lth, Lth}]}];
update_entry(W,[{W,I}|Es],Lth) ->
    [{W, update_index(I, Lth)} | Es];
update_entry(W,[E|Es],Lth) ->
    [E | update_entry(W, Es, Lth)].

update_index([{S,E}|[]],Lth) when E+1 < Lth -> 
    [{S,E}, {Lth,Lth}];
update_index([{S,_E}|[]],Lth) -> 
    [{S,Lth}];
update_index([I|Is],Lth) ->     
    [I | update_index(Is,Lth)].
