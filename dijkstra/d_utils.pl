
:- ensure_loaded(d_configs).


:- dynamic(is_safe/1).

%% Chechs is vertex is in field
is_valid(Point) :-
	Point = [X, Y],
	field(Size),

	X >= 1, X =< Size,
	Y >= 1, Y =< Size. 

%% Finds neighboor of cell
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


%% Updates resistent of stepped on mask or doc field
update_safe(Position, IsSave, NewIsSave) :-
	covid1(Covid1),
	covid2(Covid2),

	mask_position(Mask),
	doctor_position(Doc),
	(
		IsSave = true -> NewIsSave = true;

		(
		    get_neighboor(Position, Covid1, 1);
		    get_neighboor(Position, Covid2, 1)
		) -> false;

		(Position = Mask; Position = Doc) -> NewIsSave = true;

		NewIsSave = false
	).

%% update_safe(_, _, NewIsSave) :-
%% 	NewIsSave = true.