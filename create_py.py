#!/usr/bin/env python

import os
import sys
import requests
from cookies import cookies

y, d = sys.argv[1:]

path = "{y}/day{d}".format(y=y, d=d)

if not os.path.exists(path):
    os.makedirs(path)

file_template = """
from AOC import read_input

inp = read_input()
"""

with open(os.path.join(path, "part1.py"), 'a') as f:
    f.write(file_template)
    f.close()

r = requests.get(f"https://adventofcode.com/{y}/day/{d}/input", cookies=cookies)
if r.status_code == 200:
    with open(os.path.join(path, "input"), 'wb') as f:
        f.write(r.content)
        f.close()
else:
    print(r.text)





