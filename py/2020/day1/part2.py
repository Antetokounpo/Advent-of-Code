import sys

with open(sys.argv[1]) as f:
    inp = f.read()

report = list(sorted(map(int, inp.split('\n')[:-1])))

print(report)
for i in report:
    for j in report:
        if 2020-i-j in report:
            print(i*j*(2020-i-j))
            sys.exit(0)



