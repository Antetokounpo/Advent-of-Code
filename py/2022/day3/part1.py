from AOC import read_input
from string import ascii_letters

inp = read_input()

c  = 0
for i in inp.strip().split('\n'):
    l = len(i)
    c1, c2 = set(i[:l//2]), set(i[l//2:])
    c += ascii_letters.index(list(c1 & c2)[0])+1
print(c)