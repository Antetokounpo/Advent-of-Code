import sys

with open(sys.argv[1]) as f:
    inp = f.read()

report = list(sorted(map(int, inp.split('\n')[:-1])))

print(report)
for i in report:
    if 2020-i in report:
        print(i*(2020-i))
        break



