#!/usr/bin/env python3

import argparse
import os
import re
import subprocess
import sys
import time

import requests
from cookies import cookies

SUPPORTED_LANGUAGES = ['py', 'hs', 'cpp']
FILE_TEMPLATES = {
    'py': "from AOC import read_input\n\ninp = read_input()",
    'hs': "import AOC\n\nmain = do\n    inp <- readInput\n    print inp",
    'cpp': "#include<iostream>\n\nint main(int argc, char** argv){\n    return 0;\n}\n"
}

def get_dirpath(language, year, day):
    dirpath = os.path.join(language, year, f"day{day}")
    os.makedirs(dirpath, exist_ok=True)

    return dirpath

def create(language, year, day, part):
    dirpath = get_dirpath(language, year, day)

    if part == 1:
        # mode append pour éviter les accidents
        with open(os.path.join(dirpath, f"part1.{language}"), 'a') as f:
            f.write(FILE_TEMPLATES[language])
    elif part == 2:
        with open(os.path.join(dirpath, f"part1.{language}"), 'r') as f:
            part1_src = f.read()
        with open(os.path.join(dirpath, f"part2.{language}"), 'a') as f:
            f.write(part1_src)
    
    input_file_path = os.path.join(dirpath, "input")
    if not os.path.isfile(input_file_path):
        with open(input_file_path, 'wb') as f:
            f.write(get_input(year, day))

def run_py(dirpath, part):
    env = os.environ.copy()
    env['PYTHONPATH'] = 'py/lib'
    process = subprocess.Popen(['python3', os.path.join(dirpath, f"part{part}.py"), os.path.join(dirpath, "input")], stdout=subprocess.PIPE, env=env)
    stdout = process.communicate()[0]

    return stdout

def compile_hs(dirpath, part):
    r = os.system(f"ghc -O2 -ilib -o {os.path.join('tmp', 'part')} {os.path.join(dirpath, f'part{part}.hs')}")
    if r != 0:
        sys.exit(1)

def compile_cpp(dirpath, part):
    r = os.system(f"g++ -O3 -lfmt -o {os.path.join('tmp', 'part')} {os.path.join(dirpath, f'part{part}.cpp')}")
    if r != 0:
        sys.exit(1)

def run_compiled(dirpath):
    os.system(' '.join([os.path.join("tmp", "part"), os.path.join(dirpath, "input")]))

def run(language, year, day, part) -> int:
    dirpath = get_dirpath(language, year, day)

    input_file_path = os.path.join(dirpath, "input")
    if not os.path.isfile(input_file_path):
        with open(input_file_path, 'wb') as f:
            f.write(get_input(year, day))

    if language == 'py':
        start_time = time.time()
        stdout = run_py(dirpath, part)
        chrono = int((time.time()-start_time)*1e3)
        print(f"Time: {chrono} ms")
        print(stdout.decode('utf8').strip())
    elif language == 'hs':
        compile_hs(dirpath, part)
        start_time = time.time()
        run_compiled(dirpath)
        chrono = int((time.time()-start_time)*1e3)
        print(f"Time: {chrono} ms")
        #print(f"Result: {stdout.decode('utf8').strip()}")
    elif language == 'cpp':
        compile_cpp(dirpath, part)
        start_time = time.time()
        run_compiled(dirpath)
        chrono = int((time.time()-start_time)*1e3)
        print(f"Time: {chrono} ms")
    
    return chrono

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
    parser.add_argument("language", choices=SUPPORTED_LANGUAGES)

    parser.add_argument("year", type=int, choices=range(2015, 2023))
    parser.add_argument("day", type=int, choices=range(1, 26))
    parser.add_argument("part", type=int, choices=[1, 2])
    parser.add_argument("command", choices=['create', 'run'])
    args = parser.parse_args()

    if args.command == 'create':
        create(args.language, str(args.year), str(args.day), args.part)
    elif args.command == 'run':
        run(args.language, str(args.year), str(args.day), args.part)


if __name__ == '__main__':
    main()
