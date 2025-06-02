from AOC import read_input

inp = read_input()


template, rules = inp.split('\n\n')

rules = dict(rule.split(' -> ') for rule in rules.splitlines())

n_steps = 10

for _ in range(n_steps):
    num_insertions = 0
    insertions = []
    for i in range(len(template)-1):
        if insert := rules.get(template[i:i+2]):
            insertions.append((insert, i+num_insertions+1))
            num_insertions += 1
    template = list(template)
    for c, i in insertions:
        template.insert(i, c)
    template = ''.join(template)

occurences = sorted([template.count(i) for i in set(rules.values())])

print(occurences[-1] - occurences[0])


