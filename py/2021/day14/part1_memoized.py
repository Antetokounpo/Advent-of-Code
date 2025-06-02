from AOC import read_input

inp = read_input()


template, rules = inp.split('\n\n')

rules = dict(rule.split(' -> ') for rule in rules.splitlines())

n_steps = 20

def count_occurences(string):
    occurences = {i:string.count(i) for i in set(rules.values())}
    return occurences

def polymerization(step, depth):
    splitted = [step[i:i+2] for i in range(len(step)-1)]
    new_step = [get_polymer(j, depth-1) for j in splitted]
    new_step = new_step[0][:-1] + ''.join([j[:-1] for j in new_step[1:-1]]) + new_step[-1]
    return new_step

memoization = {}
def get_polymer(polymer, depth):
    assert len(polymer) == 2

    if not memoization.get(polymer):
        memoization[polymer] = {}
    if ans := memoization[polymer].get(depth):
        return ans

    step = polymer[0] + rules[polymer] + polymer[1]

    if depth == 0:
        return step

    step = polymerization(step, depth)
    memoization[polymer][depth] = step

    return step

new_polymer = polymerization(template, n_steps)
occurences = sorted([new_polymer.count(i) for i in set(rules.values())])
print(occurences[-1] - occurences[0])
