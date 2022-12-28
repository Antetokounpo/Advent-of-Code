from AOC import read_input
inp = read_input().strip()

for i in range(len(inp)-4):
    if len(set(inp[i:i+4])) == 4:
        print(i+4)
        break
