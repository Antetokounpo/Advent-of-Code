
from AOC import read_input

inp = read_input()

print(max([sum(map(int, i.split('\n'))) for i in inp.strip().split('\n\n')]))
