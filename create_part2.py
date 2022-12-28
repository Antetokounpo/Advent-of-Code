#!/usr/bin/env python

import os
import shutil
import sys

y, d, fp = sys.argv[1:]
path = "{y}/day{d}".format(y=y, d=d)

filepart = next(filter(lambda x: x.startswith('part1') and (x.endswith(fp)), os.listdir(path)))

shutil.copy(os.path.join(path, filepart), os.path.join(path, "part2."+filepart.split('.')[-1]))

