from AOC import read_input

inp = read_input()

row = 2978
col = 3083

def pairing_function(i, j):
    return int(0.5*(i+j-2)*(i+j-1)+j)

print(pairing_function(1, 1))
print(20151125*pow(252533, (pairing_function(row, col)-1), 33554393) % 33554393)