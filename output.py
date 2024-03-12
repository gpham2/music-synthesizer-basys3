import pygame
import serial
import time
import ast

def read_and_shift_data(filename='output.txt'):
    with open(filename, 'r') as file:
        lines = file.readlines()

    if not lines:
        return None
    # Read the first line
    first_line = lines[0].strip()

    # Delete the first line
    del lines[0]

    # Write every other line up by 1
    with open(filename, 'w') as file:
        file.writelines(lines)

    return first_line


def get_array_from_file(filename='output.txt'):
    data = read_and_shift_data(filename)

    
    if data:
        # Assuming the data is a list of arrays, get the first array
        data = str(data)
        # Get the 0th, 1st, 2nd, 3rd characters
        bits_to_extract = [int(data[i]) for i in range(4)]

        # Convert the extracted bits to integers
        key_to_play = int(''.join(map(str, bits_to_extract)), 2)

        # Extract bits from 4th, 5th, 6th indices
        bits_to_extract_2 = [int(data[i]) for i in range(5, 8)]
        scale_to_play = int(''.join(map(str, bits_to_extract_2)), 2)
        major = int(data[4])

        return key_to_play - 1, scale_to_play, major
        
        # return {
        #     'key': key_to_play - 1,
        #     'scale': scale_to_play,
        #     'major': major
        # }
    else:
        return None  # No data in the file
# Initialize Pygame mixer
pygame.mixer.init()

# Define the mapping of keyboard keys to note numbers
key_mapping = {
    '1': 0, '2': 1, '3': 2, '4': 3, '5': 4, '6': 5, '7': 6, '8': 7, '9': 8, '0': 9, 'q': 10, 'w': 11, 'e': 12, 'r': 13, 't': 14
}

# Define the mapping of keyboard keys to scales
# scale_mapping = {
#     'z': 'C', 'x': 'D', 'c': 'E', 'v': 'F', 'b': 'G'
# }

scale_mapping = ['C', 'D', 'E', 'F', 'G']

# Initialize the key and scale
current_key = 'C'
is_major = False
stop_option = False





# Define scales directly with sharps
C_MAJOR_SCALE = ['c3', 'd3', 'e3', 'f3', 'g3', 'a3', 'b3', 'c4', 'd4', 'e4', 'f4', 'g4', 'a4', 'b4', 'c5']
C_MINOR_SCALE = ['c3', 'd3', 'd#3', 'f3', 'g3', 'g#3', 'a#3', 'c4', 'd4', 'd#4', 'f4', 'g4', 'g#4', 'a#4', 'c5']
D_MAJOR_SCALE = ['d3', 'e3', 'f#3', 'g3', 'a3', 'b3', 'c#4', 'd4', 'e4', 'f#4', 'g4', 'a4', 'b4', 'c#5', 'd5']
D_MINOR_SCALE = ['d3', 'e3', 'f3', 'g3', 'a3', 'a#3', 'c4', 'd4', 'e4', 'f4', 'g4', 'a4', 'a#4', 'c5', 'd5']
E_MAJOR_SCALE = ['e3', 'f#3', 'g#3', 'a3', 'b3', 'c#4', 'd#4', 'e4', 'f#4', 'g#4', 'a4', 'b4', 'c#5', 'd#5', 'e5']
E_MINOR_SCALE = ['e3', 'f#3', 'g3', 'a3', 'b3', 'c4', 'd4', 'e4', 'f#4', 'g4', 'a4', 'b4', 'c5', 'd5', 'e5']
F_MAJOR_SCALE = ['f3', 'g3', 'a3', 'a#3', 'c4', 'd4', 'e4', 'f4', 'g4', 'a4', 'a#4', 'c5', 'd5', 'e5', 'f5']
F_MINOR_SCALE = ['f3', 'g3', 'g#3', 'a#3', 'c4', 'c#4', 'd#4', 'f4', 'g4', 'g#4', 'a#4', 'c5', 'c#5', 'd#5', 'f5']
G_MAJOR_SCALE = ['g3', 'a3', 'b3', 'c4', 'd4', 'e4', 'f#4', 'g4', 'a4', 'b4', 'c5', 'd5', 'e5', 'f#5', 'g5']
G_MINOR_SCALE = ['g3', 'a3', 'a#3', 'c4', 'd4', 'd#4', 'f4', 'g4', 'a4', 'a#4', 'c5', 'd5', 'd#5', 'f5', 'g5']



sound_mapping = {}
for key, note in key_mapping.items():
    current_scale = f'{current_key}_MAJOR_SCALE' if is_major else f'{current_key}_MINOR_SCALE'
    sound_file = f'{globals()[current_scale][note]}.ogg'
    sound_mapping[key] = pygame.mixer.Sound(f'./sounds/{sound_file}')


print("Loading sound files...")

# Pre-load all notes beforehand
all_notes_mapping = {}
for scale in [C_MAJOR_SCALE, C_MINOR_SCALE, D_MAJOR_SCALE, D_MINOR_SCALE, E_MAJOR_SCALE, E_MINOR_SCALE,
              F_MAJOR_SCALE, F_MINOR_SCALE, G_MAJOR_SCALE, G_MINOR_SCALE]:
    for i, note in enumerate(scale):
        all_notes_mapping[note] = pygame.mixer.Sound(f'./sounds/{note}.ogg')

print("Sound files loaded.")

# Display the initial key and scale
print(f"Current key: {current_key} {'Major' if is_major else 'Minor'}")
print('Stop option is:', stop_option)


# Main loop to receive and play notes from the keyboard
try:
    print("Listening to keyboard input...")
    while True:
        
        inputs = get_array_from_file()
        if inputs == None:
            continue

        # Get the pressed key
        # pressed_key = input("Press a key: ")
        note = inputs[0]
        current_key = scale_mapping[inputs[1]]
        is_major = inputs[2]

        if note == -1:
            continue

        # Check if the pressed key is in the note mapping
        # if pressed_key in key_mapping:
        if True:
            # note = key_mapping[pressed_key]

            # Stop the sound if the stop option is enabled
            if stop_option:
                pygame.mixer.stop()


            #if new key diff than prev key

            # for key, note in key_mapping.items():
            #     current_scale = f'{current_key}_MAJOR_SCALE' if is_major else f'{current_key}_MINOR_SCALE'
            #     sound_file = f'{globals()[current_scale][note]}.ogg'
            #     sound_mapping[key] = pygame.mixer.Sound(f'./sounds/{sound_file}')
            # print(f'Switched to key {current_key} {("Major" if is_major else "Minor")}.')

            # sound_mapping[pressed_key].play()
            current_scale = f'{current_key}_MAJOR_SCALE' if is_major else f'{current_key}_MINOR_SCALE'
            sound_file = f'{globals()[current_scale][note]}.ogg'

            # sound_mapping[note].play()

            
            pygame.mixer.Sound(f'./sounds/{sound_file}').play()
            print(f'Note {note} played.')

        # Check if the pressed key is in the scale mapping
        # elif pressed_key in scale_mapping:
        #     current_key = scale_mapping[pressed_key]

        #     # Reload sound files based on the new key
        #     for key, note in key_mapping.items():
        #         current_scale = f'{current_key}_MAJOR_SCALE' if is_major else f'{current_key}_MINOR_SCALE'
        #         sound_file = f'{globals()[current_scale][note]}.ogg'
        #         sound_mapping[key] = pygame.mixer.Sound(f'./sounds/{sound_file}')
        #     print(f'Switched to key {current_key} {("Major" if is_major else "Minor")}.')

        # Toggle between major and minor when 'y' is pressed
        # elif pressed_key == 'y':
        #     is_major = not is_major
        #     print(f'Switched to key {current_key} {("Major" if is_major else "Minor")}.')

        elif pressed_key == 'p':
            stop_option = not stop_option
            print(f'Stop flag toggled. {"Sound will stop when playing a new note." if stop_option else "Sound will overlap."}')

        # if enter is pressed stop the sound
        # elif pressed_key == '':
        #     pygame.mixer.stop()
        #     print('Sound stopped.')

except KeyboardInterrupt:
    print("\nExiting the program.")

# Clean up resources
pygame.mixer.quit()