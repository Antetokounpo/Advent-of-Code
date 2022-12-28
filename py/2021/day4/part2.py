import operator
from functools import reduce

from AOC import read_input

inp = read_input()

inp = list(map(str.splitlines, inp.split('\n\n')))

drawn = inp[0][0].split(',')
boards = [list((map(str.split, i))) for i in inp[1:]]

def bingo(board, numbers):
    marked = [[0 for _ in range(5)] for _ in range(5)]
    for i, line in enumerate(board):
        for j, n  in enumerate(line):
            if n in numbers:
                marked[i][j] = 1
    if reduce(operator.or_, [sum(i) == 5 for i in marked]) or reduce(operator.or_, [sum(i) == 5 for i in list(zip(*marked))]):
        return sum([sum([int(board[i][j]) if not b else 0 for j, b in enumerate(line)]) for i, line in enumerate(marked)])


for i in range(len(drawn)):
    boards_ = [b for b in boards if not bingo(b, drawn[:i])]
    for b in boards_:
        win = bingo(b, drawn[:i+1])
        if win and len(boards_) == 1:
            print(win*int(drawn[i]))
            break
    else:
        continue
    break



