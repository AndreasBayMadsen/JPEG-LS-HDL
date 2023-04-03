#!/usr/bin/python3
# This program takes a .ppm image, converts it to
# RGB565 and transmits the raw image over UART.

import cv2
import serial
import struct
import argparse
import numpy as np

def main(image_path, port, baud):
    # Read image file
    img = cv2.imread(image_path)

    # Convert to RGB565
    blue_img, green_img, red_img = cv2.split(img)
    red_img     = np.asarray(red_img).astype('uint16')//(2**3)
    green_img   = np.asarray(green_img).astype('uint16')//(2**2)
    blue_img    = np.asarray(blue_img).astype('uint16')//(2**3)
    rgb565_img  = red_img*(2**11) + green_img*(2**5) + blue_img*(2**0)
    rgb565_img  = np.asarray(rgb565_img).astype('uint16')

    # Transmit image
    ser = serial.Serial(port, baud,
                        serial.EIGHTBITS,
                        serial.PARITY_NONE,
                        serial.STOPBITS_ONE,
                        timeout=5)
    
    orig_array = []
    for row in range(rgb565_img.shape[0]):
        for col in range(rgb565_img.shape[1]):
            orig_array.append(rgb565_img[row][col])
            values = bytearray(struct.pack("H", rgb565_img[row][col]))  # Convert into two bytes
            temp = bytearray(len(values))
            temp[0::2] = values[1::2]
            temp[1::2] = values[0::2]
            values = temp
            ser.write(values)

    # Store received data
    bram_array = []
    while True:
        read_data = ser.read()

        if len(read_data) < 1:
            break
        else:
            bram_array.append(read_data)

    ser.close()

    # Rewrite into 32-bit lines
    bram_array_temp = []
    byte_shift_count = 3
    temp = 0
    for val in bram_array:
        temp = temp + int.from_bytes(val, 'big')*(2**(8*byte_shift_count))
        byte_shift_count = byte_shift_count - 1

        if byte_shift_count < 0:
            bram_array_temp.append(temp)
            byte_shift_count = 3
            temp = 0
    bram_array = bram_array_temp

    # Write received data to file
    with open("dump.txt", 'w') as file:
        for val in bram_array:
            file.write(f"{val:08x}\n")

    # Write original data to file to compare
    orig_array_temp = []
    word_shift_count = 1
    temp = 0
    for val in orig_array:
        temp = temp + val*(2**(16*word_shift_count))
        word_shift_count = word_shift_count - 1

        if word_shift_count < 0:
            orig_array_temp.append(temp)
            word_shift_count = 1
            temp = 0
    orig_array = orig_array_temp

    with open("dump_orig.txt", 'w') as file:
        for val in orig_array:
            file.write(f"{val:08x}\n")

if __name__ == "__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to transmit a .ppm image over UART")
    parser.add_argument('image_path', help="Path to the .ppm image")
    parser.add_argument('-p', '--port', required=True, help="Serial port to use")
    parser.add_argument('-b', '--baud', required=False, default=115200, help="Baud rate - defaults to 115200")

    args = parser.parse_args()

    main(args.image_path, args.port, args.baud)