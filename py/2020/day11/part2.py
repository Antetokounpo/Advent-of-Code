import sys
import copy

with open(sys.argv[1], 'r') as f:
    inp = f.read()

grid = list(map(list, inp.split('\n')[:-1]))
for i in range(len(grid)):
    grid[i] = ['.']+grid[i]+['.']

grid = [['.']*len(grid[0])] + grid + [['.']*len(grid[0])]


def epoch(grid):
    next_grid = copy.deepcopy(grid)
    for i in range(1, len(grid)-1):
        for j in range(1, len(grid[0])-1):
            if grid[i][j] == '.':
                continue
            
            c = 0
            for x in range(-1, 2):
                for y in range(-1, 2):
                    u = i+x
                    v = j+y
                    if not x and not y:
                        continue
                    while True:
                        if u < 0 or u == len(grid) or v < 0 or v == len(grid[0]):
                            break
                        elif grid[u][v] == 'L':
                            break
                        elif grid[u][v] == '#':
                            c += 1
                            break
                        u += x
                        v += y

            if not c and grid[i][j] == 'L':
                next_grid[i][j] = '#'
            elif c > 4 and grid[i][j] == '#':
                next_grid[i][j] = 'L'
    return next_grid

c = 0
while True:
    n_grid = epoch(grid)
    c += 1
    if n_grid == grid:
        print(sum(map(lambda x: x.count('#'), n_grid)))
        break
    grid = n_grid
