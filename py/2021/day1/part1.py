from AOC import read_input

ds = read_input().splitlines()
ds = list(map(int, ds))
print([j>i for i, j in zip(ds[:-1], ds[1:])].count(True))