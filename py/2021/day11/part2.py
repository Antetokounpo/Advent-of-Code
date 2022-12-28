
from AOC import read_input
import copy
import numpy as np

inp = read_input()

grid = np.array([[int(j) for j in i] for i in inp.strip().split('\n')])
n, m = grid.shape

def step(grid):
    new_grid = grid.copy()
    new_grid += 1

    flashes = list(zip(*np.where(new_grid > 9)))
    while flashes:
        i, j = flashes.pop()
        new_grid[i, j] = 0

        for di in range(-1, 2):
            for dj in range(-1, 2):
                if di+i < 0 or dj+j < 0:
                    continue
                try:
                    if new_grid[di+i, dj+j]:
                        new_grid[di+i, dj+j] += 1
                except IndexError:
                    continue
        flashes = list(zip(*np.where(new_grid > 9)))
    
    return new_grid

i = 0
while True:
    grid = step(grid)
    if not grid.any():
        print(i+1)
        break
    i += 1
