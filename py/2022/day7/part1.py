from AOC import read_input
from dataclasses import dataclass
from typing import Dict
from functools import reduce

inp = read_input()

class File:
    def __init__(self):
        self.size = 0
    
    def set_size(self, value):
        self.size = value
    
    def get_size(self):
        return self.size

class Directory:
    def __init__(self):
        self.children = {}
    
    def add_directory(self, name):
        self.children[name] = Directory()
    
    def add_file(self, name, size):
        self.children[name] = File()
        self.children[name].set_size(size)
    
    def access_path(self, path):
        match path:
            case [p]:
                return self.children[p]
        return self.children[path[0]].access_path(path[1:])
    
    def get_size(self):
        return sum([i.get_size() for i in self.children.values()])

directory = Directory()
commands = [i.strip() for i in inp.split('$ ')]
cwd = ['/']
directory.add_directory('/')
for c in commands[2:]:
    match c.split():
        case ["cd", ".."]:
            cwd.pop()
        case ["cd", _dir]:
            directory.access_path(cwd).add_directory(_dir)
            cwd.append(_dir)
        case ["ls", *files]:
            for t, f in zip(files[::2], files[1::2]):
                match [t, f]:
                    case ["dir", _dir]:
                        directory.access_path(cwd).add_directory(_dir)
                    case [size, name]:
                        directory.access_path(cwd).add_file(name , int(size))

selected_dirs = []
def get_dir_sizes(_dir):
    selected_dirs.append(_dir.get_size())
    _dirs = [i for i in _dir.children.values() if isinstance(i, Directory)]
    for i in _dirs:
        get_dir_sizes(i)
get_dir_sizes(directory)
print(sum([i for i in selected_dirs if i <= 100000]))
