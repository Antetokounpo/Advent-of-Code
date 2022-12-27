from AOC import read_input
inp = read_input().strip()

n = 14

for i in range(len(inp)-n):
    if len(set(inp[i:i+n])) == n:
        print(i+n)
        break
