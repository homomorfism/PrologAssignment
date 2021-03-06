# PrologAssignment

Link to source code: 
- ```https://github.com/homomorfism/PrologAssignment``` 
- Please text me to add you to collaborator to see the code.


How to run programs: 
- ```time swipl -s [file].pl -g main -g halt```



Description of using algoritms: 
- backtracking: naive implementation of backtracking algorithm without any heuristics, it takes so long to execute, not recommented to use for finding minimum paths. Before stepping of the neighboor field, check if actor is resistent or the field is not infected. 

- dijkstra: I store gamefield as a list of edges(From, To, Cost), each Cost is equals to 1. I traverse through each neighboor point and find the minimum path. Also, I store information about resistance to covid (IsResistent), which is true when the actor was on mask or doctor position.


PEAS model of actor:

- agent type:
	* actor

- perfomance measure: 
	* found minimum path from actor to home

- actuators:
	* making (moves) on the game field
	* abitily to collect a mask or be vaccinated

- environment: 
	* field map with covid, mask and doctor zones

- sensors:
	* information about current position (relative position to the game field boarders)
	* distance to home field
	* information about infected cells (when staying close to them)



Impossible paths: 
- Map 1 (doc, mask, home is surrounded by covid), tested on both algorithms (execution time on backracting is ~ 12 min.)

![map1](images/map1.jpg)
