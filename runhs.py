#!/usr/bin/env python3
import os
import sys


y, d, p = sys.argv[1:]

path = "{y}/day{d}".format(y=y, d=d)

os.system("runhaskell -ilib {path}/part{p} {path}/input".format(path=path, p=p))

