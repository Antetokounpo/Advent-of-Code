
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
    bonus = your_hand.index(y)+1
    if translations[o] == y:
        score += 3
    elif translations[o] != your_hand[bonus % 3]:
        score += 6
    score += bonus

print(score)

