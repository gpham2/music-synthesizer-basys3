import keyboard

def read_data_from_file(filename='output.txt'):
    with open(filename, 'r') as file:
        lines = file.readlines()
        return [eval(line.strip()) for line in lines]

def get_array_from_file(filename='output.txt'):
    data = read_data_from_file(filename)
    
    if data:
        # Assuming the data is a list of arrays, get the first array
        array_value = data[0]

        # parse 4 left most bit, extract the number it represents and then turn that number into int
        bits_to_extract = [0, 1, 2, 3]
        extracted_bits = [array_value[0] >> i & 1 for i in bits_to_extract]
        key_to_play = int(''.join(map(str, extracted_bits)), 2)

        # extract bit 4, 5, 6 and convert to int
        bits_to_extract_2 = [5, 6, 7]
        extracted_bits = [array_value[0] >> i & 1 for i in bits_to_extract_2]
        scale_to_play = int(''.join(map(str, extracted_bits)), 2)

        # convert 4th bit to int
        major = array_value[0] >> 4 & 1

        return {
            'key': key_to_play,
            'scale': scale_to_play,
            'major': major
        }
    else:
        return None  # No data in the file
    

def test_function():
    result = get_array_from_file()
    if result:
        print("Data from file:", result)
    else:
        print("No data in the file.")

# Register the hotkey
keyboard.on_press_key("p", test_function)

while True:
    # Perform other tasks in the loop if needed
    time.sleep(1) 
    