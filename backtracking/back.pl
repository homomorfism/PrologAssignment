
:- ensure_loaded(b_utils).

%% Backtracing function
back(Home, Home, _, [], _) :-
	true.


%% Backtracing function
back(From, To, VisitedPath, Path, Resistent) :-
	get_neighboor(From, X, 1),

	\+ member(X, VisitedPath),
	update_resistence(X, Resistent, NewResistent),
	\+ is_infected(X, NewResistent),

	length(VisitedPath, L), L < 11,

	NewVisited = [X | VisitedPath],

	back(X, To, NewVisited, LastPath, NewResistent),

	Path = [X | LastPath].


%% Backtracing start execution
main :-
	start(Start),
	end(End),

	(
		bagof(
			Path,
			back(Start, End, [Start], Path, false),
			AllPaths
		) ->

	
			length(AllPaths, L),
			write("Found paths: "), write(L),

			find_shortest_path(AllPaths, MinPath),

			Path = [Start | MinPath],
			length(Path, Length),
			Length1 is Length - 1,

			format('\nPaths: ~w, length: ~w\n', [Path, Length1]);

		write("No path exists!")

	).





