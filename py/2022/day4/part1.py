from AOC import read_input

inp = read_input()


assignments = [[j for j in i.split(',')] for i in inp.strip().split('\n')]
c = 0
for i, j in assignments:
    i_start, i_end = map(int, i.split('-'))
    j_start, j_end = map(int, j.split('-'))

    if j_start <= i_start <= i_end <= j_end:
        c += 1
    elif i_start <= j_start <= j_end <= i_end:
        c += 1

print(c)