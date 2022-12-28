import AOC

inp = AOC.read_input()

dirs = inp.split('\n')[:-1]

possible_facing = ['E', 'S', 'W', 'N']
caxe = 0
cdir = 1
c = 0
p = [0,0]
for i in dirs:
    d = i[0]
    v = int(i[1:])

    if d == 'R':
        c = (c+v//90) % 4
        continue
    elif d == 'L':
        c = (c-v//90) % 4
        continue

    if d == 'F':
        d = possible_facing[c]

    if d == 'N':
        p[1] += v
    elif d == 'S':
        p[1] -= v
    elif d == 'E':
        p[0] += v
    elif d == 'W':
        p[0] -= v


print(abs(p[0])+abs(p[1]))

