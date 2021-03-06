
:- ensure_loaded(b_config).

% Searching for min path in ListPaths
find_shortest_path([Head | Tail], MinPath) :-
	length(Head, Length),
	find_shortest_path(Tail, Length, Head, MinPath).

find_shortest_path([], _, CurrentMin, CurrentMin).
find_shortest_path([Head | Tail], MinLength, CurrentMin, MinPath) :-
	length(Head, Length),
	
	(
		Length =< MinLength ->
			find_shortest_path(Tail, Length, Head, MinPath);

		find_shortest_path(Tail, MinLength, CurrentMin, MinPath)
	).




is_same(Position1, Position2) :-
	Position1 = [XPosition1, YPosition1],
	Position2 = [XPosition2, YPosition2],

	XPosition1 =:= XPosition2,
	YPosition1 =:= YPosition2.



is_valid(Point) :-
	Point = [X, Y],
	field(Size),

	X >= 1, X =< Size,
	Y >= 1, Y =< Size. 


get_neighboor(Point, Neighboor, Step) :-
	Point = [X, Y],
	
	(
		Step = 1 ->
			member([XStep, YStep], [
				[1,0],[1,1],[0,1],[1,-1],
				[0,-1],[-1,-1],[-1,0],[-1,1]
			]);

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


is_infected(Position, Resistent) :-
	covid1(Covid1),
	covid2(Covid2),
	zone(Step),

	(
		Resistent -> false;
		get_neighboor(Covid1, Position, Step) -> true;
		get_neighboor(Covid2, Position, Step) -> true;
		false
	).

update_resistence(Position, Resistent, NewResistent) :-
	mask_position(MaskPosition),
	doctor_position(DoctorPosition),
	
	(
		Resistent -> NewResistent = true;
		
		is_same(Position, MaskPosition)		-> NewResistent = true;
		is_same(Position, DoctorPosition)	-> NewResistent = true;
		NewResistent = false

	).



dist(Point1, Point2, Distance) :-
	Point1 = [X1, Y1],
	Point2 = [X2, Y2],

	N is abs(X1 - X2),
	K is abs(Y1 - Y2),

	Distance is max(N, K).






