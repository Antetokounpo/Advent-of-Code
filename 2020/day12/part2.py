import AOC
from math import sin, cos, radians


inp = AOC.read_input()

dirs = inp.split('\n')[:-1]


p = [0,0]
w = [10, 1]
for i in dirs:
    d = i[0]
    v = int(i[1:])
    
    if d == 'R':
        t = radians(-v)
        w = [w[0]*cos(t) - w[1]*sin(t), w[0]*sin(t) + w[1]*cos(t)]
    elif d == 'L':
        t = radians(v)
        w = [w[0]*cos(t) - w[1]*sin(t), w[0]*sin(t) + w[1]*cos(t)]

    if d == 'F':
        p[0] += v*w[0]
        p[1] += v*w[1]

    if d == 'N':
        w[1] += v
    elif d == 'S':
        w[1] -= v
    elif d == 'E':
        w[0] += v
    elif d == 'W':
        w[0] -= v

print(int(abs(p[0])+abs(p[1])))

