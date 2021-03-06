
:- ensure_loaded(b_utils).

path(X, X, _, [], _) :-
	true.


path(From, To, VisitedPath, Path, Resistent) :-
	get_neighboor(From, X),

	\+ member(X, VisitedPath),
	update_resistence(X, Resistent, NewResistent),
	\+ is_infected(X, NewResistent),

	length(VisitedPath, L), L < 12,

	NewVisited = [X | VisitedPath],

	path(X, To, NewVisited, LastPath, NewResistent),

	Path = [X | LastPath].

main :-
	start(Start),
	end(End),

	bagof(
		Path,
		path(Start, End, [Start], Path, false),
		AllPaths
	),

	
	length(AllPaths, L),
	write("Found paths: "), write(L),
	%% write("\nAll paths: "), write(AllPaths),

	find_shortest_path(AllPaths, MinPath),

	write("\nPaths: "), write([Start | MinPath]),
	write("\n").



