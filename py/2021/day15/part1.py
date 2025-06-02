from AOC import read_input
import numpy as np
import itertools

inp = read_input()

cavemap = inp.splitlines()
cavemap = np.array(list(map(lambda x: list(map(int, list(x))), cavemap)))
distance = np.ones_like(cavemap)*np.inf
unvisited = set(itertools.product(range(cavemap.shape[0]), range(cavemap.shape[1])))


distance[0, 0] = 0

while unvisited:
    u = min(unvisited, key=lambda ind: distance[*ind])

    unvisited.remove(u)

    neighbors = [
        (u[0]+1, u[1]),
        (u[0]-1, u[1]),
        (u[0], u[1]+1),
        (u[0], u[1]-1),
    ]

    neighbors = filter(lambda x: x in unvisited, neighbors)

    for n in neighbors:
        new_distance = distance[u] + cavemap[n]
        if new_distance < distance[n]:
            distance[n] = new_distance

print(int(distance[-1, -1]))
