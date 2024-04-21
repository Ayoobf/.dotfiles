#!python3

import subprocess
import os


for dir in os.listdir("."):
    if os.path.isdir(dir) and (dir == ".git" or dir == ".idea"):
        try:
            subprocess.run(["stow", dir])
        except FileNotFoundError:
            print(f"{dir} failed nothing to do")
