from AOC import read_input
import matplotlib.pyplot as plt
import numpy as np
from functools import reduce
import operator

inp = read_input()

lavatubes = [list(map(int, i)) for i in inp.splitlines()]

n, m = len(lavatubes), len(lavatubes[0])
mins = []
for i, a in enumerate(lavatubes):
    for j, b in enumerate(a):
        if i != 0 and b >= lavatubes[i-1][j]:
            continue
        if i != n - 1 and b >= lavatubes[i+1][j]:
            continue
        if j != 0 and b >= lavatubes[i][j-1]:
            continue
        if j != m - 1 and b >= lavatubes[i][j+1]:
            continue
        mins.append((i, j))

def crawl_basin(i, j):
    points = []
    def _crawl_basin(i, j):
        if (i, j) in points or lavatubes[i][j] == 9:
            return
        points.append((i, j))
        if i > 0:
            _crawl_basin(i-1, j)
        if i < n - 1:
            _crawl_basin(i+1, j)
        if j > 0:
            _crawl_basin(i, j-1)
        if j < m - 1:
            _crawl_basin(i, j+1)
    _crawl_basin(i, j)
    return points

print(reduce(operator.__mul__, sorted([len(crawl_basin(*i)) for i in mins])[-1:-4:-1]))
