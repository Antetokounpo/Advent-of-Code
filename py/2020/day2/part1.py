import sys

with open(sys.argv[1], 'r') as f:
    inp = f.read()

c = 0
for line in inp.split('\n')[:-1]:
    rang, char, string = line.split(' ')
    a, b = map(int, rang.split('-'))
    occ = string.count(char[0])
    if occ <= b and occ >= a:
        c += 1
print(c)
