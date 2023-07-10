from AOC import read_input

inp = read_input()


paths = {}
for path in inp.splitlines():
    a, b = path.split('-')
    paths[a] = paths.get(a, []) + [b]
    paths[b] = paths.get(b, []) + [a]

caves = list(paths.keys())
big_caves = list(filter(lambda x: x == x.upper(), caves))

all_paths = []

def dfs(cave, path=[]):
    if cave == 'end':
        all_paths.append(path+[cave])
        return
    for next_cave in paths[cave]:
        if next_cave in big_caves or next_cave not in path:
            dfs(next_cave, path+[cave])

dfs('start')
print(len(all_paths))