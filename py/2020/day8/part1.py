import sys

with open(sys.argv[1], 'r') as f:
    inp = f.read()


acc = 0
pc = 0
pc_hist = []

program = inp.split('\n')

while True:
    instr, arg = program[pc].split(' ')
    if pc in pc_hist:
        print(acc)
        break
    pc_hist.append(pc)
    if instr == 'nop':
        pc += 1
    elif instr == 'jmp':
        pc += int(arg)
    elif instr == 'acc':
        acc += int(arg)
        pc += 1
