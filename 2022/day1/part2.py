
from AOC import read_input

inp = read_input()

a = [sum(map(int, i.split('\n'))) for i in inp.strip().split('\n\n')]
a.sort()
print(sum(a[-3:]))
