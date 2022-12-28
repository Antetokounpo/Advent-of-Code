from AOC import read_input
import numpy as np

inp = read_input()

a = [list(map(int, i)) for i in inp.split()]
a = np.array(a)

n, m = a.shape

visible_trees = 0
for i in range(1, n-1):
    for j in range(1, m-1):
        if np.max(a[:i, j]) < a[i, j]:
            visible_trees += 1
        elif np.max(a[i+1:, j]) < a[i, j]:
            visible_trees += 1
        elif np.max(a[i, :j]) < a[i, j]:
            visible_trees += 1
        elif np.max(a[i, j+1:]) < a[i, j]:
            visible_trees += 1

print(visible_trees + 2*n + 2*m - 4)
