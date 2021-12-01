
from AOC import read_input

ds = read_input().splitlines()
ds = list(map(int, ds))
ds = [sum(i) for i in zip(ds[:-2], ds[1:-1], ds[2:])]
print([j>i for i, j in zip(ds[:-1], ds[1:])].count(True))