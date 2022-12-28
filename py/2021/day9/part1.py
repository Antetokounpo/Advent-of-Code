from AOC import read_input

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
        mins.append(b)
            

print(sum(mins)+len(mins))