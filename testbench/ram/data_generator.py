import numpy as np

RAM_SIZE = 2**13
DATA_BITS = 16

data = np.random.randint(0, 2**DATA_BITS, size=RAM_SIZE)

file_content = []
for i, val in enumerate(data):
    file_content.append(f"{i};{val:04x}\n")

with open('ram_data.csv', 'w+') as f:
    f.writelines(file_content)
