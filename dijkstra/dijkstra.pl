:- include(d_graph).
:- dynamic(mypath/2).
:- dynamic(edge/3).
:- ensure_loaded(d_configs).


%% retracts all long paths
shorterPath([Node|Path], Distance) :-
    (
        mypath([Node|_], D) 
            -> Distance < D 
                -> retract(mypath([Node|_], _)); 
            true
    ),
    assertz(mypath([Node|Path], Distance)). 



%% Inmpemetation of dijkstra algoritm
dijkstra(From, Path, Cost, IsSafe) :-
    edge(From, T, D),
    \+ memberchk(T, Path),
    update_safe(T, IsSafe, NewIsSave),
    shorterPath([T,From|Path], Cost+D),
    dijkstra(T, [From|Path], Cost+D, NewIsSave).

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
    