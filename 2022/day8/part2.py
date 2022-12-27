from AOC import read_input
import numpy as np

inp = read_input()

a = [list(map(int, i)) for i in inp.split()]
a = np.array(a)
a = np.pad(a, 1, constant_values=10)

n, m = a.shape

visible_trees = 0
max_scenic = 0
for i in range(2, n-2):
    for j in range(2, m-2):
        directions = (
            a[:i, j][::-1],
            a[i+1:, j],
            a[i, :j][::-1],
            a[i, j+1:],
        )

        score = 1
        for d in directions:
            t = np.argmax(d >= a[i, j])
            if d[t] != 10:
                t += 1
            score *= t
        if score > max_scenic:
            max_scenic = score

print(max_scenic)
