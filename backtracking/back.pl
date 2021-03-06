
:- ensure_loaded(b_utils).

path(X, X, _, [], _) :-
	true.


path(From, To, VisitedPath, Path, Resistent) :-
	get_neighboor(From, X, 1),

	\+ member(X, VisitedPath),
	update_resistence(X, Resistent, NewResistent),
	\+ is_infected(X, NewResistent),

	length(VisitedPath, L), L < 11,

	NewVisited = [X | VisitedPath],

	path(X, To, NewVisited, LastPath, NewResistent),

	Path = [X | LastPath].

main :-
	start(Start),
	end(End),

	(
		bagof(
			Path,
			path(Start, End, [Start], Path, false),
			AllPaths
		) ->

	
			length(AllPaths, L),
			write("Found paths: "), write(L),

			find_shortest_path(AllPaths, MinPath),

			Path = [Start | MinPath],
			length(Path, Length),

			format('\nPaths: ~w, length: ~w\n', [Path, Length]);

		write("No path exists!")

	).





