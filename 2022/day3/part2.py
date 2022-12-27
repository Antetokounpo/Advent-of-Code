from AOC import read_input
from string import ascii_letters

inp = read_input()


rucksacks = inp.strip().split('\n')
c  = 0
for i in range(0, len(rucksacks), 3):
    s = rucksacks[i:i+3]
    badge = list(map(set, s))
    badge = badge[0].intersection(*badge[1:])
    c += ascii_letters.index(list(badge)[0])+1

print(c)