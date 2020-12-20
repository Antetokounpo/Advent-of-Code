#!/usr/bin/env python3
import os
import sys


y, d, p = sys.argv[1:]

path = "{y}/day{d}".format(y=y, d=d)

ret = os.system("ghc --make -ilib {path}/part{p}.hs".format(path=path, p=p))
if ret:
    sys.exit(1)
os.system("{path}/part{p} {path}/input".format(path=path, p=p))

