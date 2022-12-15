from pathlib import Path

dirs = [
        "ip/**/*.vhdl",
        "modules/**/*.vhdl",
        "project/**/*.vhdl",
        "ip/**/*.vhd",
        "modules/**/*.vhd",
        "project/**/*.vhd"
        ]

p = Path.cwd()

for d in dirs:
    for file in p.glob(d):
        print(file)
