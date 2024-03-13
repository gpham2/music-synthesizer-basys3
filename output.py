import pygame

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
        data = str(data)
        bits_to_extract = [int(data[i]) for i in range(4)]

        # Convert the extracted bits to integers
        key_to_play = int(''.join(map(str, bits_to_extract)), 2)

        # Extract bits from 4th, 5th, 6th indices
        bits_to_extract_2 = [int(data[i]) for i in range(5, 8)]
        scale_to_play = int(''.join(map(str, bits_to_extract_2)), 2)
        major = int(data[4])
        return key_to_play - 1, scale_to_play, major
    else:
        return None  # No data in the file
    
# Initialize Pygame mixer
pygame.mixer.init()

scale_mapping = ['C', 'D', 'E', 'F', 'G']
current_key = 'C'
is_major = False
stop_option = True





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



# Display the initial key and scale
print(f"Current key: {current_key} {'Major' if is_major else 'Minor'}")
print('sustain pedal is :', stop_option)


# Main loop to receive and play notes from the keyboard
try:
    print("Listening to keyboard input...")
    while True:
        
        inputs = get_array_from_file()
        if inputs == None:
            continue

        # Get the pressed key
        note = inputs[0]
        current_key = scale_mapping[inputs[1]]
        is_major = inputs[2]

        if note == -1:
            continue


        if stop_option:
            pygame.mixer.stop()


        current_scale = f'{current_key}_MAJOR_SCALE' if is_major else f'{current_key}_MINOR_SCALE'
        sound_file = f'{globals()[current_scale][note]}.ogg'

        pygame.mixer.Sound(f'./sounds/{sound_file}').play()
        print(f'Note {note} played.')

    
except KeyboardInterrupt:
    print("\nExiting the program.")

# Clean up resources
pygame.mixer.quit()