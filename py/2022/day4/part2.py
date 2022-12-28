from AOC import read_input

inp = read_input()


assignments = [[j for j in i.split(',')] for i in inp.strip().split('\n')]
c = 0
for i, j in assignments:
    i_start, i_end = map(int, i.split('-'))
    j_start, j_end = map(int, j.split('-'))

    if i_start in range(j_start, j_end+1) or i_end in range(j_start, j_end+1):
        c += 1
    elif j_start in range(i_start, i_end+1) or j_end in range(i_start, i_end+1):
        c += 1

print(c)