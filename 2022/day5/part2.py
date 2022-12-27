from AOC import read_input
from functools import partial

inp = read_input()

stacks, moves = inp.split('\n\n')

stacks = map(partial(filter, lambda x: x not in "[] "), zip(*stacks.split('\n')[:-1]))
stacks = [i[::-1] for i in list(filter(bool, (map(list, stacks))))]

for m in moves.strip().split('\n'):
    n, src, dst = map(int, m.split()[1::2])

    col = [stacks[src-1].pop() for _ in range(n)][::-1]

    stacks[dst-1] += col
    
print(''.join([i[-1] for i in stacks]))
