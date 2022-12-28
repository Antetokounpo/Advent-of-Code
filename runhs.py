#!/usr/bin/env python3
import os
import sys


y, d, p = sys.argv[1:]

path = os.path.abspath("{y}/day{d}".format(y=y, d=d))

r = os.system("ghc -O2 -ilib {path}/part{p}".format(path=path, p=p))
if r != 0:
    sys.exit(1)
print("Running part{p}.hs...".format(p=p))
os.system(os.path.abspath(f"{path}/part{p}") + " " f"{path}/input")

