#!/usr/bin/env python3

import os
import re
import sys

import requests
from cookies import cookies

supported_languages = ['py', 'hs']
file_templates = {
    'py': "from AOC import read_input\n\ninp = read_input()",
    'hs': "import AOC\n\nmain = do\n    inp <- readInput\n    print inp"
}

year, day, language = sys.argv[1:]

if not re.fullmatch(r"^\d{4}$", year):
    print(f"Année invalide: {year}")
    sys.exit(1)

if not re.fullmatch(r"^\d{1,2}$", day):
    print(f"Jour invalide: {day}")
    sys.exit(1)

if language not in supported_languages:
    print(f"Langage '{language}' non supporté")
    sys.exit(1)

dirpath = os.path.join(language, year, f"day{day}")

# mode append pour éviter les accidents
with open(os.path.join(dirpath, f"part1.{language}"), 'a') as f:
    f.write(file_template[language])
    f.close()

r = requests.get(f"https://adventofcode.com/{y}/day/{d}/input", cookies=cookies)
if r.status_code == 200:
    with open(os.path.join(dirpath, 'input'), 'wb') as f:
        f.write(r.content)
        f.close()
else:
    print("Erreur dans la requête")
    print(r.text)
    sys.exit(1)

