import timeit
from scipy.stats import ttest_ind

command_dijkstra = 'import os; os.system("swipl -s /home/shamil/PrologAssignment/dijkstra/dijkstra.pl -g main -g halt")'
command_back = 'import os; os.system("swipl -s /home/shamil/PrologAssignment/backtracking/back.pl -g main -g halt")'
count = 20

dijkstra = [timeit.timeit(command_back, number=1) for i in range(count)]

# _, p_value = ttest_ind(back, dijkstra)

print(dijkstra)
