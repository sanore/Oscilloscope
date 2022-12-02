# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                     #
# Oscilloscope                                                        #
# Miniproject Digital Microelectronics (Fall Semester 2022)           #
# OST Rapperswil-Jona                                                 #
#                                                                     #
# Group 7:   Pele Constam                                             #
#            Sandro Pedrett                                           #
#            Erik Loeffler                                            #
#                                                                     #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

import numpy as np
import matplotlib.pyplot as plt

# wave shapes in order
#   1. sine
#   2. sawtooth
#   3. rectangular
#   4. random (uniformly distributed)
SAMPLES_PER_WAVE_PERIOD = 10000
PERIODS_PER_WAVE_SHAPE = 2
MAX_ADC_VALUE = 2**12 - 1

TRIGGER_VALUE = 2500

FILE_NAMES = {"rising_edge": "rising_edge_test.csv",
              "falling_edge": "falling_edge_test.csv",
              "both_edges": "both_edges_test.csv"}

# generate test data
test_data = np.ndarray((4*SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE,),
        dtype=np.uint16)

# generate sine wave
timebase_sin = np.linspace(0, 2*np.pi,
                           SAMPLES_PER_WAVE_PERIOD)

sin_data = np.round(MAX_ADC_VALUE//2*np.sin(timebase_sin) + MAX_ADC_VALUE//2)
# store sine wave
for i in range(PERIODS_PER_WAVE_SHAPE):
    test_data[i*SAMPLES_PER_WAVE_PERIOD:(i + 1)*SAMPLES_PER_WAVE_PERIOD] = sin_data

# generate sawtooth
sawtooth_values = np.ndarray((SAMPLES_PER_WAVE_PERIOD,), dtype=np.uint16)
dy_over_dx = MAX_ADC_VALUE / SAMPLES_PER_WAVE_PERIOD
for i in range(SAMPLES_PER_WAVE_PERIOD):
    sawtooth_values[i] = i*dy_over_dx
# store sawtooth
for i in range(PERIODS_PER_WAVE_SHAPE):
    test_data[SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE + 
              i*SAMPLES_PER_WAVE_PERIOD:
                  SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE + 
                  (i + 1)*SAMPLES_PER_WAVE_PERIOD] = sawtooth_values

# generate rectangular
mid_point = SAMPLES_PER_WAVE_PERIOD//2
rect_data = np.ndarray((SAMPLES_PER_WAVE_PERIOD,), dtype=np.uint16)
for i in range(SAMPLES_PER_WAVE_PERIOD):
    if i < mid_point:
        rect_data[i] = 0
    else:
        rect_data[i] = MAX_ADC_VALUE
# store rectangular
for i in range(PERIODS_PER_WAVE_SHAPE):
    test_data[2*SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE + 
              i*SAMPLES_PER_WAVE_PERIOD:
                  2*SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE + 
                  (i + 1)*SAMPLES_PER_WAVE_PERIOD] = rect_data

# generate random pattern
test_data[3*SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE:] = \
    np.round(np.random.uniform(low=0, high=MAX_ADC_VALUE,
                             size=SAMPLES_PER_WAVE_PERIOD*PERIODS_PER_WAVE_SHAPE))

# determine rising edge trigger and save to file
output_lines = ["0000\n", # trigger mode
                "0001\n", # trigger sel
                f"{TRIGGER_VALUE:012b}\n"] # trigger threshold
output_lines.append(f"{test_data[0]:012b};0\n")
fir0 = test_data[0] // 4
fir1 = 0
fir2 = 0
fir3 = 0
last_value = 0
current_value = test_data[0] // 4
for i in range(1, test_data.shape[0]):

    fir3 = fir2
    fir2 = fir1
    fir1 = fir0
    fir0 = test_data[i]

    last_value = current_value
    current_value = fir0 // 4 + fir1 // 4 + fir2 // 4 + fir3 // 4

    if current_value >= TRIGGER_VALUE and last_value <= TRIGGER_VALUE:
        output_lines.append(f"{test_data[i]:012b};1\n")
    else:
        output_lines.append(f"{test_data[i]:012b};0\n")

# store file
with open(FILE_NAMES['rising_edge'], 'w+') as f:
    f.writelines(output_lines)

# determine falling edge trigger and save to file
output_lines = ["0000\n", # trigger mode
                "0010\n", # trigger sel
                f"{TRIGGER_VALUE:012b}\n"] # trigger threshold
output_lines.append(f"{test_data[0]:012b};0\n")

fir0 = test_data[0] // 4
current_value = test_data[0] // 4

for i in range(1, test_data.shape[0]):
    fir3 = fir2
    fir2 = fir1
    fir1 = fir0
    fir0 = test_data[i]

    last_value = current_value
    current_value = fir0 // 4 + fir1 // 4 + fir2 // 4 + fir3 // 4

    if test_data[i] <= TRIGGER_VALUE and test_data[i - 1] >= TRIGGER_VALUE:
        output_lines.append(f"{test_data[i]:012b};1\n")
    else:
        output_lines.append(f"{test_data[i]:012b};0\n")

# store file
with open(FILE_NAMES['falling_edge'], 'w+') as f:
    f.writelines(output_lines)

# determine trigger for both edges and save to file
output_lines = ["0000\n", # trigger mode
                "0011\n", # trigger sel
                f"{TRIGGER_VALUE:012b}\n"] # trigger threshold
output_lines.append(f"{test_data[0]:012b};0\n")

fir0 = test_data[0] // 4
current_value = test_data[0] // 4

for i in range(1, test_data.shape[0]):

    fir3 = fir2
    fir2 = fir1
    fir1 = fir0
    fir0 = test_data[i]

    last_value = current_value
    current_value = fir0 // 4 + fir1 // 4 + fir2 // 4 + fir3 // 4

    if test_data[i] <= TRIGGER_VALUE and test_data[i - 1] >= TRIGGER_VALUE or\
        test_data[i] >= TRIGGER_VALUE and test_data[i - 1] <= TRIGGER_VALUE:
        output_lines.append(f"{test_data[i]:012b};1\n")
    else:
        output_lines.append(f"{test_data[i]:012b};0\n")

# store file
with open(FILE_NAMES['both_edges'], 'w+') as f:
    f.writelines(output_lines)

plotx = np.arange(test_data.shape[0])
plt.plot(plotx, test_data)
