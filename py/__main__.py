#!/usr/bin/env python3

import argparse
from importlib import import_module
import os
import sys
import time

import requests
from cookies import cookies

FILE_TEMPLATES = {
    'py': "from AOC import read_input\n\ninp = read_input()",
}

def get_dirpath(year, day):
    dirpath = os.path.join(year, f"day{day}")
    os.makedirs(dirpath, exist_ok=True)

    return dirpath

def get_filepath(year, day, part):
    return os.path.join(get_dirpath(year, day), f"part{part}.py")

def create(year, day, part):
    dirpath = get_dirpath(year, day)

    if part == 1:
        # mode append pour éviter les accidents
        with open(os.path.join(dirpath, f"part1.py"), 'a') as f:
            f.write(FILE_TEMPLATES[language])
    elif part == 2:
        with open(os.path.join(dirpath, f"part1.py"), 'r') as f:
            part1_src = f.read()
        with open(os.path.join(dirpath, f"part2.py"), 'a') as f:
            f.write(part1_src)
    
    input_file_path = os.path.join(dirpath, "input")
    if not os.path.isfile(input_file_path):
        with open(input_file_path, 'wb') as f:
            f.write(get_input(year, day))

def run_py(year, day, part):
    import_module('.'.join((year, f'day{day}', f'part{part}')))

def run(year, day, part):
    dirpath = get_dirpath(year, day)

    input_file_path = os.path.join(dirpath, "input")
    if not os.path.isfile(input_file_path):
        with open(input_file_path, 'wb') as f:
            f.write(get_input(year, day))
    
    os.environ['AOC_INPUT'] = os.path.join(dirpath, 'input')

    run_py(year, day, part)

def get_input(y, d):
    r = requests.get(f"https://adventofcode.com/{y}/day/{d}/input", cookies=cookies)
    if r.status_code == 200:
            return r.content
    else:
        print("Erreur dans la requête")
        print(r.text)
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("year", type=int, choices=range(2015, 2023))
    parser.add_argument("day", type=int, choices=range(1, 26))
    parser.add_argument("part", type=int, choices=[1, 2])
    args = parser.parse_args()

    year = str(args.year)
    day = str(args.day)
    part = args.part

    filepath = os.path.isfile(get_filepath(year, day, part))

    if os.path.isfile(filepath):
        run(year, day, part)
    else:
        print(f"{filepath} created.")
        create(year, day, part)


if __name__ == '__main__':
    main()
