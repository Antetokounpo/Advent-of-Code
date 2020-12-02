import sys

with open(sys.argv[1], 'r') as f:
    inp = f.read()

c = 0
for line in inp.split('\n')[:-1]:
    rang, char, string = line.split(' ')
    a, b = map(int, rang.split('-'))

    if (string[a-1] == char[0]) ^ (string[b-1] == char[0]):
        c += 1
print(c)
