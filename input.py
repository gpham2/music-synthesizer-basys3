import serial
import time

# Open the serial port (update 'COMx' with the actual port your FPGA is connected to)
# ser = serial.Seriaal('COM1', baudrate=9600, timeout=1)

# Function to open the serial port
def open_serial_port(port_name):
    ser = serial.Serial(
            port=port_name,
            baudrate=1000000,
            bytesize=serial.EIGHTBITS,  # 8 data bits
            parity=serial.PARITY_NONE,  # No parity
            stopbits=serial.STOPBITS_ONE,  # 1 stop bit
            timeout=1
        )
    return ser

# Function to check if the serial port is open
def is_serial_port_open(ser):
    return ser.isOpen()

# Function to close the serial port
def close_serial_port(ser):
    ser.close()


def write_data_to_file(data, filename='test.txt'):
    with open(filename, 'a') as file:
        file.write(str(data) + '\n')

port_name = 'COM32'

# Open the serial port
ser = open_serial_port(port_name)
print(ser)

prev_byte = None
start_time = time.time()
timeout_duration = .25  # Specify the timeout duration in seconds

try:
    # Check if the serial port is open
    if is_serial_port_open(ser):
        print(f"Serial port {port_name} is open.")

        while True:
            byte = ser.read(1)

            if byte != b'' and (time.time() - start_time > timeout_duration or (byte and byte != prev_byte)):
                start_time = time.time()
                prev_byte = byte

                # byte should be 21 bits long turn it into array of size 8 of booleans
                byte = int.from_bytes(byte, byteorder='big')
                array_value = [bool(int(bit)) for bit in format(byte, '08b')]
                # print("Received byte:", array_value)

                # ser.write(bytes(array_value))
                write_data_to_file(array_value)


                print("Sent array:", array_value)


except KeyboardInterrupt:
    print("Script terminated by user.")
finally:
    # Close the serial port on script termination
    ser.close()


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
