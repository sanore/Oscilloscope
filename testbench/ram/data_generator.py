import numpy as np
import random

ADDR_BITS = 13
DATA_BITS = 16

data = np.random.randint(0, 2**DATA_BITS, size=2**ADDR_BITS)

file_content = []
for i, val in enumerate(data):
    file_content.append(f"{i:0{ADDR_BITS}b};{val:0{DATA_BITS}b}\n")

# shuffle lines for random RAM access
random.shuffle(file_content)

with open('ram_data.csv', 'w+') as f:
    f.writelines(file_content)
