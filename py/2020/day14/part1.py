import AOC

inp = AOC.read_input()

inp = inp.split('\n')[:-1]
mask = inp[0].split(' ')[-1]
mems = inp[1:]

mem = [0 for _ in range(0, 65536)]

def apply_mask(val):
    new_bin = []
    bin_val = bin(int(val))[2:]
    bin_val = '0'*(len(mask)-len(bin_val)) + bin_val
    for i in range(len(mask)):
        if mask[i] == 'X':
            new_bin.append(bin_val[i])
        else:
            new_bin.append(mask[i])
    return ''.join(new_bin)

for i in mems:
    if i.startswith('mask'):
        mask = i.split(' ')[-1]
        continue
    addr, val = i.split(" = ")
    addr = int(addr[4:-1])
    mem[addr] = int('0b'+apply_mask(val), 2)

print(sum(mem))

