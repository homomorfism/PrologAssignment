
:- ensure_loaded(d_configs).


:- dynamic(is_safe/1).

is_valid(Point) :-
	Point = [X, Y],
	field(Size),

	X >= 1, X =< Size,
	Y >= 1, Y =< Size. 


get_neighboor(Point, Neighboor, Step) :-
	Point = [X, Y],
	(
		Step = 1 ->
			member([XStep, YStep], [[1,0],[1,1],[0,1],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1]]);

		Step = 2 ->
			member([XStep, YStep], [
				[-2,-2], [-2,-1], [-2, 0], [-2, 1], [-2, 2],
				[-1, 2], [ 0, 2], [ 1, 2], [ 2, 2],
				[ 2, 1], [ 2, 0], [ 2,-1], [ 2,-2],
				[ 1,-2], [ 0,-2], [-1,-2]
				])
	),


	NewX is X + XStep,
	NewY is Y + YStep,

	New = [NewX, NewY],

	is_valid(New),
	Neighboor = New.


update_safe(Position, IsSave, NewIsSave) :-
	covid1(Covid1),
	covid2(Covid2),
	zone(Step),


	mask_position(Mask),
	doctor_position(Doc),
	(
		IsSave = true -> NewIsSave = true;

		(Position = Mask; Position = Doc) -> NewIsSave = true;

		(get_neighboor(Position, Covid1, Step); get_neighboor(Position, Covid2, Step)) -> false;
		NewIsSave = false
	).

%% update_safe(_, _, NewIsSave) :-
%% 	NewIsSave = true.