from AOC import read_input
import numpy as np

inp = read_input()

dots_position, folds = inp.split('\n\n')

dots_position = np.array([tuple(int(j) for j in i.split(',')) for i in dots_position.splitlines()])

paper = np.zeros((np.max(dots_position[:, 1])+1, np.max(dots_position[:, 0])+1), dtype=bool)

for i, j in dots_position:
    paper[j, i] = True

axis, index = folds.splitlines()[0].split('=')
axis = axis[-1]
index = int(index)

if axis == 'x':
    first_half = paper[:, :index]
    second_half = paper[:, index+1:]
    second_half = second_half[:, ::-1]

    len_1 = first_half.shape[1]
    len_2 = second_half.shape[1]
    if len_1 > len_2:
        second_half = np.pad(second_half, ((0, 0), (len_1-len_2, 0)), constant_values=False)
    else:
        first_half = np.pad(first_half, ((0, 0), (len_2-len_1, 0)), constant_values=False)

    new_paper = first_half | second_half
elif axis == 'y':
    first_half = paper[:index, :]
    second_half = paper[index+1:, :]
    second_half = second_half[::-1, :]

    len_1 = first_half.shape[0]
    len_2 = second_half.shape[0]
    if len_1 > len_2:
        second_half = np.pad(second_half, ((len_1-len_2, 0), (0, 0)), constant_values=False)
    else:
        first_half = np.pad(first_half, ((len_2-len_1, 0), (0, 0)), constant_values=False)

    new_paper = first_half | second_half

print(new_paper.sum())