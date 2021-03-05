
:- ensure_loaded(configs).


:- dynamic(is_safe/1).

is_valid(Point) :-
	Point = [X, Y],
	field(Size),

	X >= 1, X =< Size,
	Y >= 1, Y =< Size. 


get_neighboor(Point, Neighboor) :-
	Point = [X, Y],
	member([XStep, YStep], [[1,0],[1,1],[0,1],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]),

	NewX is X + XStep,
	NewY is Y + YStep,

	New = [NewX, NewY],

	is_valid(New),
	Neighboor = New.


update_safe(Position, IsSave, NewIsSave) :-
	covid1(Covid1),
	covid2(Covid2),


	mask_position(Mask),
	doctor_position(Doc),
	(
		IsSave = true -> NewIsSave = true;

		(Position = Mask; Position = Doc) -> NewIsSave = true;

		(get_neighboor(Position, Covid1); get_neighboor(Position, Covid2)) -> false;
		NewIsSave = false
	).

%% update_safe(_, _, NewIsSave) :-
%% 	NewIsSave = true.