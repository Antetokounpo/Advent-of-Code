
from AOC import read_input
import copy
import numpy as np

inp = read_input()

grid = np.array([[int(j) for j in i] for i in inp.strip().split('\n')])
n, m = grid.shape

flash_count = 0

def step(grid):
    new_grid = grid.copy()
    new_grid += 1

    flashes = list(zip(*np.where(new_grid > 9)))
    while flashes:
        i, j = flashes.pop()
        new_grid[i, j] = 0
        global flash_count
        flash_count += 1

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

for _ in range(100):
    grid = step(grid)

print(flash_count)