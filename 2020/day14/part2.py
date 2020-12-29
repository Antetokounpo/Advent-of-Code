import AOC
import itertools

inp = AOC.read_input()

mems = inp.split('\n')[:-1]

def apply_mask(val):
    new_bin = []
    bin_val = bin(int(val))[2:]
    bin_val = '0'*(len(mask)-len(bin_val)) + bin_val
    l = 0
    for i in range(len(mask)):
        if mask[i] == 'X':
            l += 1
            new_bin.append('{}')
        elif mask[i] == '0':
            new_bin.append(bin_val[i])
        else:
            new_bin.append(mask[i])
    return [''.join(new_bin).format(*i) for i in itertools.product('01', repeat=l)]


addrs = []
vals = []
for i in mems:
    if i.startswith('mask'):
        mask = i.split(' ')[-1]
        continue
    addr, val = i.split(" = ")
    addr = int(addr[4:-1])
    masked_addrs = apply_mask(addr)
    addrs += masked_addrs
    vals += [int(val)]*len(masked_addrs)
uaddrs = list(set(addrs))
new_addrs = [uaddrs.index(i) for i in addrs]

mem = [0 for _ in range(len(uaddrs))]
for i in range(len(new_addrs)):
    mem[new_addrs[i]] = vals[i]

print(sum(mem))

