:- include(d_graph).
:- dynamic(mypath/2).
:- dynamic(edge/3).
:- ensure_loaded(d_configs).


path(From, To, Dist):- edge(From, To, Dist);
                        edge(To, From, Dist).

shorterPath([H|Path], Dist) :-
    (
        mypath([H|_], D) 
            -> Dist < D 
                -> retract(mypath([H|_], _)); 
            true
    ),
    assertz(mypath([H|Path], Dist)). 

dijkstra(From, Path, Dist, IsSafe) :-
    path(From, T, D),
    \+ memberchk(T, Path),
    update_safe(T, IsSafe, NewIsSave),
    shorterPath([T,From|Path], Dist+D),
    dijkstra(T, [From|Path], Dist+D, NewIsSave).

dijkstra(From, IsSafe) :-
    retractall(mypath(_, _)),
    dijkstra(From, [], 0, IsSafe).

dijkstra(_, _).

calc(From, To, IsSafe) :-
    fill_edges,

    dijkstra(From, IsSafe),
    mypath([To|RPath], Dist) ->
        reverse([To|RPath], Path),
        Distance is Dist,
        format('The shortest path is ~w with distance ~w\n', [Path, Distance]);
    write("Path does not exists!").


main :-
    start(Start),
    end(End),
    calc(Start, End, false).
    