import numpy as np

inp = "315679824"
cups_n = 1000000


def move_cups(cups):
    p, c1, c2, c3 = cups[:4]
    cups_ = cups[4:]

    label = 0
    for i in range(1, cups_n):
        label = (p-i) % (cups_n + 1)
        if label not in [p, c1, c2, c3, 0]:
            break
    index = np.where(cups_==label)[0][0]
    xs = cups_[:(index+1)]
    ys = cups_[(index+1):]

    return np.concatenate((xs, np.array([c1, c2, c3]), ys, np.array([p])), axis=None)

cups = list(map(int, list(inp))) + list(range(10, cups_n+1))
cups = np.array(cups)

moves = 10000000

for _ in range(moves):
    cups = move_cups(cups)

j = np.where(cups==1)[0][0]

print(cups[j+1] * cups[j+2])
