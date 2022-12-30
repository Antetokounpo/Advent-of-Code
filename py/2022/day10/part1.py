from AOC import read_input
from pdb import set_trace

inp = read_input().splitlines()
x = 1
cycles = 0
signals = []

def next_cycle():
    global cycles
    cycles += 1
    if (cycles == 20) or ((cycles - 20) % 40 == 0):
        print(cycles, x)
        signals.append(cycles*x)

for i in inp:
    match i.split():
        case ['noop']:
            next_cycle()
        case ['addx', n]:
            next_cycle()
            next_cycle()
            x += int(n)

print(sum(signals))
