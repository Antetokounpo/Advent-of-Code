from AOC import read_input

inp = read_input()


paths = {}
for path in inp.splitlines():
    a, b = path.split('-')
    if a != 'end' and b != 'start':
        paths[a] = paths.get(a, []) + [b]
    if b != 'end' and a != 'start':
        paths[b] = paths.get(b, []) + [a]

caves = list(paths.keys())
n = len(caves)
big_caves = list(filter(lambda x: x == x.upper(), caves))

all_paths = []

def dfs(cave, path=[]):
    new_path = path+[cave]

    if cave == 'end':
        all_paths.append(new_path)
        return

    visited_small_caves = list(filter(lambda x: x.lower() == x, new_path))

    for next_cave in paths[cave]:
        if next_cave in big_caves or next_cave not in path or len(list(set(visited_small_caves))) == len(visited_small_caves):
            dfs(next_cave, new_path)
dfs('start')
print(len(all_paths))