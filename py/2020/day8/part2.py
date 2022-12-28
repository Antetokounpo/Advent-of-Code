import sys

with open(sys.argv[1], 'r') as f:
    inp = f.read()


def check_infinite_loop(program):
    acc = 0
    pc = 0
    pc_hist = []

    while True:
        if pc >= len(program):
            print(acc)
            return False
        if pc in pc_hist:
            return True
        pc_hist.append(pc)
        instr, arg = program[pc].split(' ')
        if instr == 'nop':
            pc += 1
        elif instr == 'jmp':
            pc += int(arg)
        elif instr == 'acc':
            acc += int(arg)
            pc += 1

program = inp.split('\n')[:-1]
for i, line in enumerate(program):
    pgrm_copy = program.copy()
    instr, arg = line.split(' ')
    if instr == 'jmp':
        pgrm_copy[i] = ' '.join(['nop', arg])
        if check_infinite_loop(pgrm_copy):
            continue
        else:
            break
    elif instr == 'nop':
        pgrm_copy[i] = ' '.join(['jmp', arg])
        if check_infinite_loop(pgrm_copy):
            continue
        else:
            break