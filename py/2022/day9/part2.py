from AOC import read_input
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

inp = read_input()

motions = [i.split() for i in inp.strip().split('\n')]

head_pos = np.array([0, 0], dtype=np.float32)
tail_pos = [[head_pos.copy()] for _ in range(9)]

def distance(a, b):
    return np.max(np.abs(b - a), axis=-1)

for m in motions:
    d, n = m[0], int(m[1])

    for _ in range(n):

        next_head_pos = head_pos.copy()
        match d:
            case 'L':
                next_head_pos[0] -= 1
            case 'R':
                next_head_pos[0] += 1
            case 'U':
                next_head_pos[1] += 1
            case 'D':
                next_head_pos[1] -= 1
        

        if distance(tail_pos[0][-1], next_head_pos) > 1:
            tail_pos[0].append(head_pos.copy())
        head_pos = next_head_pos

        for i in range(1, 9):
            if distance(tail_pos[i-1][-1], tail_pos[i][-1]) < 2:
                continue

            relative_move = tail_pos[i-1][-1] - tail_pos[i-1][-2]
            relative_pos = tail_pos[i-1][-1] - tail_pos[i][-1]
            if not np.all(relative_pos):
                tail_pos[i].append(tail_pos[i][-1]+relative_pos/2)
            elif np.all(relative_move):
                tail_pos[i].append(tail_pos[i][-1]+relative_move)
            else:
                tail_pos[i].append(tail_pos[i-1][-2].copy())

        # Pour visualiser
        """
        current_pos = np.array([i[-1] for i in tail_pos])
        mat_pos = np.zeros((25, 25))
        for i, p in enumerate(current_pos):
            x = int(p[0]) + 12
            y = -int(p[1]) + 12
            mat_pos[y, x] = i+1
        current_head_pos = (-int(head_pos[1])+12, int(head_pos[0])+12)
        mat_pos[current_head_pos] = 10
        mat_pos[12, 12] = 12
        sns.heatmap(mat_pos)
        plt.show()
        """

print(np.unique(tail_pos[-1], axis=0).shape[0])
