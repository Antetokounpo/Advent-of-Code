import sys
import numpy as np


with open(sys.argv[1], 'r') as f:
    inp = f.read()

adapters = [0] + list(sorted(map(int, inp.split('\n')[:-1])))
n = len(adapters)

e = []

for i in range(n):
    for j in range(i+1, n):
        d =  (adapters[j] - adapters[i]) 
        if d and d < 4:
            e.append((i, j))

a = np.zeros((n, n))
for i, j in e:
    a[i, j] = 1

print(int(sum([np.linalg.matrix_power(a, i)[0, n-1] for i in range(1, n)])))
