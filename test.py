import keyboard
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

        
        return {
            'key': key_to_play,
            'scale': scale_to_play,
            'major': major
        }
    else:
        return None  # No data in the file
    

def test_function(event = None):
    result = get_array_from_file()
    if result:
        print("Data from file:", result)
    else:
        print("No data in the file.")

# Register the hotkey


def write_data_to_file(event = None, bit_string = "10110111", filename='output.txt'):
    with open(filename, 'a') as file:
        file.write(bit_string + '\n')




def write_note(event = None, filename='output.txt'):
    user_input = input("Enter a value: ")

    # Ensure the input is within the range 0-15
    try:
        value = int(user_input)
        if 0 <= value <= 15:
            # Convert the integer to a 4-bit binary string
            bit_string = format(value, '04b')
            print("4-bit binary representation:", bit_string)
            write_data_to_file(None, bit_string + "1001")
        else:
            print("Please enter a value between 0 and 15.")
    except ValueError:
        print("Invalid input. Please enter a valid integer.")

keyboard.on_press_key("p", test_function)
keyboard.on_press_key("l", write_note)

while True:
    # Perform other tasks in the loop if needed
    time.sleep(1) 
    