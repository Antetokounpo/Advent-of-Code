from AOC import read_input

inp = read_input()


template, rules = inp.split('\n\n')

rules = dict(rule.split(' -> ') for rule in rules.splitlines())

n_steps = 40

pair_count = {}

splitted = [template[i:i+2] for i in range(len(template)-1)]

for s in splitted:
    pair_count[s] = pair_count.get(s, 0) + 1


letter_count = {l:template.count(l) for l in set(template)}

for i in range(n_steps):
    new_pair_count = pair_count.copy()
    for k, v in pair_count.items():
        new_pair_count[k] -= v
        new_element = rules[k]
        letter_count[new_element] = letter_count.get(new_element, 0) + v

        new_pairs = (k[0]+new_element, new_element+k[1])
        for p in new_pairs:
            new_pair_count[p] = new_pair_count.get(p, 0) + v

    pair_count = new_pair_count

letter_count = letter_count.values()
print(max(letter_count) - min(letter_count))
