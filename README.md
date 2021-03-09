# PrologAssignment

Link to source code: 
- ```https://github.com/homomorfism/PrologAssignment``` 
- Please text me to add you to collaborator to see the code.


How to run programs: 
- ```time swipl -s [file].pl -g main -g halt```



Description of using algoritms: 

- backtracking: naive implementation of backtracking algorithm without any heuristics, it takes so long to execute, not recommented to use for finding minimum paths. Before stepping of the neighboor field, check if actor is resistent or the field is not infected. 

- dijkstra: I store gamefield as a list of edges(From, To, Cost), each Cost is equals to 1. I traverse through each neighboor point and find the minimum path. Also, I store information about resistance to covid (IsResistent), which is true when the actor was on mask or doctor position.


I tested programs on n=20 examples.

Statictical analysis:
- backtracting
	* range = 1
		* mean = 305.57
		* std = 2.269

	* range = 2
		* mean = 7.049
		* std = 0.056


- dijkstra:
	* range = 1:
		* mean = 0.269
		* std = 0.007

	* range = 2:
		* mean = 0.246
		* std = 0.007


Values: 
	- back(1): 
		* [308.6391164489978, 303.7759414999964, 304.4108637889949, 305.6654304889962, 303.2408647819975, 302.49782397099625, 307.9610317600018, 304.4842530850001, 308.9329794200021, 302.45753051799693, 302.7016417959967, 308.123541124005, 304.69595062200096, 304.87818221300404, 309.8800927150005, 306.7053972420035, 304.7569813009977, 306.24044399800187, 307.8055612780008, 303.5160200340033]

	- back(2): 
		* [10.671632207995572, 10.701378380996175, 10.76503447000141, 10.745196473995748, 10.734084171002905, 10.6944200930011, 10.702972491002583, 10.692625657997269, 10.623839859996224, 10.641906434000703, 10.748719180002809, 10.650762272001884, 10.789235911994183, 10.769501732997014, 7.436745635997795, 10.685369658000127, 10.57587232300284, 10.763681855001778, 10.544214012996235, 10.660161642001185]

	- dijkstra(1): 
		* [0.3339028269983828, 0.3425407040049322, 0.33449099200515775, 0.33367343500140123, 0.3255993490020046, 0.3357500210040598, 0.32200255100178765, 0.3375343379957485, 0.3275711269961903, 0.3360459589966922, 0.3201877270039404, 0.3324546029980411, 0.320127874998434, 0.335392168002727, 0.322627236993867, 0.3422734620035044, 0.32414685499679763, 0.3351375589991221, 0.3346898469972075, 0.33748612699855585]


	- dijkstra(2): 
		* [0.300188168999739, 0.29291656099667307, 0.3040465359954396, 0.3060282139995252, 0.30183206099900417, 0.3062014300012379, 0.30958947299950523, 0.3034138470029575, 0.3050194370007375, 0.2948963349990663, 0.30030070900102146, 0.2942259240007843, 0.31114969799818937, 0.29407115199865075, 0.3264785010032938, 0.2986077559980913, 0.2979192009952385, 0.30485626900190255, 0.29925757800083375, 0.31222556099965004]



Calculating p-values: 

- back(1) vs dijkstra(1)
	* p_value = $8.52161479432998 * e^{-77}$ <- The most

- back(2) vs dijkstra(2)
	* p_value = $6.106355350316858 * e^{-40}$

- back(1) vs back(2)
	* p_value = $1.8499721955030445 * e^{-75}$

- dijkstra(1) vs dijkstra(2)
	* p_value = $1.3272494564707883 * e^{-14}$



PEAS model of actor:

- agent type:
	* actor (player)

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
	* information about infected cells when staying close to them

Environment is:

- partially observable
	* actor does not have information about all cells in the map

- deterministic
	* game does not contain any random elements - any change in-game field is fully controlled by the player move

- Single Agent
	* there is no other player, only one agent is playing

- sequential
	*  all moves made by AI algorithms will affect future steps

- discrete
	* there are states in the environment (positions of figures), in this game, there are a finite set of steps, that players can perform

- known
	* there are a complete set of rules of how all figures can move

- static:
	* only the actions of an agent modify game field. There is no other processes are operating on it.


Impossible paths: 
- Map 1 (doc, mask, home is surrounded by covid), tested on both algorithms (execution time on backracting is ~ 12 min.)

![map1](images/map1.jpg)
