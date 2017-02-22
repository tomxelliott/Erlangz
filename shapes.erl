-module(shapes).

-export([area/1,perimeter/1,enclose/1,bits/1]).

% area is the function that Simon uses in the video.
% I have augmented it to include more shapes.
area({circle, R}) ->
	math:pi()*R*R;
area({rectangle, H, W}) ->
	H*W;
area({triangle, A, B, C}) ->
	S = (A + B + C) / 2,
	math:sqrt(S * (S - A) * (S - B) * (S - C)).

perimeter({rectangle, H,W}) ->
	H*2+W*2;
perimeter({circle,R}) ->
	2*math:pi()*R;
perimeter({triangle,A,B,C}) ->
	A+B+C.


enclose({circle, R}) ->
	{rectangle, R * 2, R * 2};
enclose({rectangle, W, H}) ->
  	{rectangle, W, H};
enclose(T = {triangle, A, B, C}) ->
  	Area = area(T),
  	Base = max(max(A, B), max(B, C)),
  	Height = (Area * 2) / Base,
  	{rectangle, Base, Height}.

bits(0) -> 
	0; 
bits(N) -> 
	N rem 2 + bits(N div 2).
