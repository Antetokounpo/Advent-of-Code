
from AOC import read_input

inp = read_input()

inp = inp.splitlines()

inp = zip(*inp)

gamme = ''.join(['1' if i.count('1') > i.count('0') else '0' for i in inp])

epsi = ''.join(['0' if i == '1' else '1' for i in gamme])
print(int(gamme, 2)*int(epsi, 2))
print(int(epsi, 2))