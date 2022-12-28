from AOC import read_input
import numpy as np

inp = read_input()

motions = [i.split() for i in inp.strip().split('\n')]

head_pos = np.array([0, 0], dtype=np.float32)
tail_pos = [head_pos.copy()]

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
        if distance(tail_pos[-1], next_head_pos) > 1:
            tail_pos.append(head_pos.copy())
        head_pos = next_head_pos

print(np.unique(tail_pos, axis=0).shape[0])
