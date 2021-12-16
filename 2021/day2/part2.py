
from AOC import read_input

inp = read_input()
inp = inp.splitlines()

horizontal = 0
vertical = 0
aim = 0

for i in inp:
    print(i)
    d, j = i.split()
    j = int(j)
    if d == "forward":
        horizontal += j
        vertical += aim*j
    if d == "down":
        aim += j
    if d == "up":
        aim -= j
print(vertical*horizontal)