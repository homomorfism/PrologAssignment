:- ensure_loaded(d_utils).



fill_edges :-
	retractall(edges(_, _, _)),
	field(Size),


	findall(Num, between(1, Size, Num), L),

	findall( [X, Y], (member(X, L), member(Y, L)), ListPairs),


	forall(
		(member(Point, ListPairs), get_neighboor(Point, Neighboor, 1)),
		assertz(edge(Point, Neighboor, 1))
	).