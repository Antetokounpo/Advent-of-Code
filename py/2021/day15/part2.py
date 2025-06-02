from AOC import read_input
import numpy as np
import itertools
import heapq
import sys


inp = read_input()

cavemap = inp.splitlines()
cavemap = np.array(list(map(lambda x: list(map(int, list(x))), cavemap)))

cavemap = np.concatenate([cavemap+i for i in range(5)], axis=0)
cavemap = np.concatenate([cavemap+i for i in range(5)], axis=1)
mod_cavemap = np.mod(cavemap, 10)
cavemap = mod_cavemap + (mod_cavemap != cavemap)

distance = np.ones_like(cavemap)*np.inf
heuristic_evaluation = np.copy(distance)

distance[0, 0] = 0
heuristic_evaluation[0, 0] = np.sum(cavemap.shape)

unvisited = [(heuristic_evaluation[0, 0], (0, 0))]
heapq.heapify(unvisited)

while unvisited:
    f, u = heapq.heappop(unvisited)

    neighbors = [
        (u[0]+1, u[1]),
        (u[0]-1, u[1]),
        (u[0],   u[1]+1),
        (u[0],   u[1]-1),
    ]

    neighbors = filter(lambda x: x[0] >= 0 and x[0] < cavemap.shape[0] and x[1] >= 0 and x[1] < cavemap.shape[1], neighbors)

    for n in neighbors:
        new_distance = distance[u] + cavemap[n]
        if new_distance < distance[n]:
            distance[n] = new_distance
            heuristic_evaluation[n] = new_distance + np.sum(np.abs([np.array(cavemap.shape) - np.array(n)]))
            heapq.heappush(unvisited, (heuristic_evaluation[n], n))
            # pas nécessaire, car l'heuristique est admissible et consistent
            #if n not in unvisited:
            #    unvisited.add(n)

print(int(distance[-1, -1]))
