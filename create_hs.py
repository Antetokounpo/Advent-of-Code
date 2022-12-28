#!/usr/bin/env python

import os
import shutil
import sys
import requests
from cookies import cookies

y, d = sys.argv[1:]

path = "{y}/day{d}".format(y=y, d=d)

if not os.path.exists(path):
    os.makedirs(path)

file_template = """
import AOC

main = do
    inp <- readInput
    print inp
"""

with open(os.path.join(path, "part1.hs"), 'a') as f:
    f.write(file_template)
    f.close()

shutil.copy(os.path.join("lib", "AOC.hs"), os.path.join(path, "AOC.hs"))

r = requests.get(f"https://adventofcode.com/{y}/day/{d}/input", cookies=cookies)
if r.status_code == 200:
    with open(os.path.join(path, "input"), 'wb') as f:
        f.write(r.content)
        f.close()
else:
    print(r.text)
