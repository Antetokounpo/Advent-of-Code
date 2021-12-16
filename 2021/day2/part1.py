
from AOC import read_input

inp = read_input()

inp = inp.splitlines()

horizontal = 0
vertical = 0

for i in inp:
    d, j = i.split()
    j = int(j)
    if d == "forward":
        horizontal += j
    if d == "down":
        vertical += j
    if d == "up":
        vertical -= j
print(vertical*horizontal)