#!/usr/bin/env python3
import os
import sys


y, d, p = sys.argv[1:]

path = "{y}/day{d}".format(y=y, d=d)

r = os.system("ghc -O2 -ilib {path}/part{p}".format(path=path, p=p))
if r != 0:
    sys.exit(1)
print("Running part{p}.hs...".format(p=p))
os.system("{path}/part{p} {path}/input".format(path=path, p=p))

