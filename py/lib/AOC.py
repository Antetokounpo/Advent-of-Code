import os
import sys

def read_input():
    filepath = os.environ.get('AOC_INPUT', sys.argv[1])
    with open(filepath, 'r') as f:
        inp = f.read()

    return inp
