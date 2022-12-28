
from AOC import read_input

inp = read_input()

translations = {
    'A': 'X',
    'B': 'Y',
    'C': 'Z'
}

rounds = [tuple(i.split()) for i in inp.strip().split('\n')]

your_hand = "XYZ"

score = 0
for o, y in rounds:
    i = your_hand.index(translations[o])
    if y == 'X':
        score += (i - 1) % 3 + 1
    elif y == 'Y':
        score += 3 + (i + 1)
    else:
        score += 6 + (i + 1) % 3 + 1 

print(score)

