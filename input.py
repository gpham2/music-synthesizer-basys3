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


def write_data_to_file(bit_string, filename='output.txt'):
    with open(filename, 'a') as file:
        file.write(bit_string + '\n')


port_name = 'COM39'

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

                # byte should be 8 bits long turn it into array of size 8 of 1s or 0s
                byte_as_int = int.from_bytes(byte, byteorder='big')
                bit_string = format(byte_as_int, '08b')

                print("Sent array:", bit_string)

                write_data_to_file(bit_string)




except KeyboardInterrupt:
    print("Script terminated by user.")
finally:
    # Close the serial port on script termination
    ser.close()


def read_data_from_file(filename='output.txt'):
    with open(filename, 'r') as file:
        lines = file.readlines()
        return [eval(line.strip()) for line in lines]
