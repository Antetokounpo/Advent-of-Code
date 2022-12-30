from AOC import read_input

inp = read_input().splitlines()
x = 1
cycles = 0
crt_screen = []

def next_cycle():
    global cycles
    if cycles % 40 in (x-1, x, x+1):
        crt_screen.append('#')
    else:
        crt_screen.append('.')
    cycles += 1

for i in inp:
    match i.split():
        case ['noop']:
            next_cycle()
        case ['addx', n]:
            next_cycle()
            next_cycle()
            x += int(n)

print(*[''.join(crt_screen[i:i+40]) for i in range(0, 240, 40)], sep='\n')
