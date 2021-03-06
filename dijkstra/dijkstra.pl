:- include(d_graph).
:- dynamic(rpath/2).
:- dynamic(edge/3).
:- ensure_loaded(d_configs).


path(From, To, Dist):- edge(From, To, Dist);
                        edge(To, From, Dist).

shorterPath([H|Path], Dist) :-
    (
        rpath([H|_], D) 
            -> Dist < D 
                -> retract(rpath([H|_], _)); 
            true
    ),
    assertz(rpath([H|Path], Dist)). 

traverse(From, Path, Dist, IsSafe) :-
    path(From, T, D),
    \+ memberchk(T, Path),
    update_safe(T, IsSafe, NewIsSave),
    shorterPath([T,From|Path], Dist+D),
    traverse(T, [From|Path], Dist+D, NewIsSave).

traverse(From, IsSafe) :-
    retractall(rpath(_, _)),
    traverse(From, [], 0, IsSafe).

traverse(_, _).

calc(From, To, IsSafe) :-
    fill_edges,

    traverse(From, IsSafe),
    rpath([To|RPath], Dist) ->
        reverse([To|RPath], Path),
        Distance is Dist,
        format('The shortest path is ~w with distance ~w\n', [Path, Distance]);
    format('There is no route from ~w to ~w\n', [From, To]).


main :-
    start(Start),
    end(End),
    calc(Start, End, false).
    