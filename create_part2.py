#!/usr/bin/env python

import os
import shutil
import sys

y, d = sys.argv[1:]
path = "{y}/day{d}".format(y=y, d=d)

shutil.copy(os.path.join(path, "part1.py"), os.path.join(path, "part2.py"))

