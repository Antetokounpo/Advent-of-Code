
from AOC import read_input

inp = read_input()
inp = inp.splitlines()

bit_pos = list(zip(*inp))

bit_crit_oxygene = inp[:]
b = list(zip(*bit_crit_oxygene))
for i in range(len(bit_pos)):
    if b[i].count('1') >= b[i].count('0'):
        c = '1'
    else:
        c = '0'
    bit_crit_oxygene = list(filter(lambda x: x[i] == c, bit_crit_oxygene))
    if len(bit_crit_oxygene) == 1:
        break
    b = list(zip(*bit_crit_oxygene))

oxygene = bit_crit_oxygene[0]

bit_crit_co2 = inp[:]
b = list(zip(*bit_crit_co2))
for i in range(len(bit_pos)):
    if b[i].count('1') < b[i].count('0'):
        c = '1'
    else:
        c = '0'
    bit_crit_co2 = list(filter(lambda x: x[i] == c, bit_crit_co2))
    if len(bit_crit_co2) == 1:
        break
    b = list(zip(*bit_crit_co2))

co2 = bit_crit_co2[0]

print(int(oxygene, 2) * int(co2, 2))