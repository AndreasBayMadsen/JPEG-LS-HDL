#!/usr/bin/python3
# This program takes a .ppm image, converts it to
# RGB565 and transmits the raw image over UART.

import os
import cv2
import serial
import struct
import argparse
import numpy as np
from bitarray import bitarray

def main(image_path, width, height, port_tx, port_rx, baud_tx, baud_rx, output_path):
    # Determine output path
    if output_path==None:
        output_path = os.path.splitext(image_path)[0] + '.jls'
    
    print(f"Output path: {output_path}")

    # Delete output file if it already exists
    if os.path.exists(output_path):
        os.remove(output_path)

    # Read image file
    img = cv2.imread(image_path)
    
    if width is not None and height is not None:
        img = cv2.resize(img, (int(width), int(height)))
        print(f"Resizing image to {img.shape}")

    # Convert to RGB565
    blue_img, green_img, red_img = cv2.split(img)
    red_img     = np.asarray(red_img).astype('uint16')//(2**3)
    green_img   = np.asarray(green_img).astype('uint16')//(2**2)
    blue_img    = np.asarray(blue_img).astype('uint16')//(2**3)
    rgb565_img  = red_img*(2**11) + green_img*(2**5) + blue_img*(2**0)
    rgb565_img  = np.asarray(rgb565_img).astype('uint16')

    # Set up ports
    ser_tx = serial.Serial(port_tx, baud_tx,
                        serial.EIGHTBITS,
                        serial.PARITY_NONE,
                        serial.STOPBITS_ONE,
                        timeout=5)

    if port_rx==None:
        ser_rx = ser_tx
        port_rx = port_tx
    else:
        ser_rx = serial.Serial(port_rx, baud_rx,
                            serial.EIGHTBITS,
                            serial.PARITY_NONE,
                            serial.STOPBITS_ONE,
                            timeout=5)

    print(f"Starting transmission to port {port_tx}...")

    # Transmit image
    orig_array = []
    for row in range(rgb565_img.shape[0]):
        for col in range(rgb565_img.shape[1]):
            orig_array.append(rgb565_img[row][col])
            values = bytearray(struct.pack("H", rgb565_img[row][col]))  # Convert into two bytes
            temp = bytearray(len(values))
            temp[0::2] = values[1::2]
            temp[1::2] = values[0::2]
            values = temp
            ser_tx.write(values)

    print(f"Starting receiving from port {port_rx}")
    # Receive compressed bitstream
    bits = bitarray()
    while True:
        read_data = ser_rx.read()

        if len(read_data) < 1:
            break
        else:
            bits.frombytes(read_data)

    ser_tx.close()
    ser_rx.close()

    # Write binary data to file
    with open(output_path, 'wb') as ofile:
        bits.tofile(ofile)


if __name__ == "__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to transmit a .ppm image over UART")
    parser.add_argument('image_path', help="Path to the .ppm image")
    parser.add_argument('-wi', '--width', required=False, help="Width to resize image")
    parser.add_argument('-hi', '--height', required=False, help="Height to resize image")
    parser.add_argument('-ptx', '--port_tx', required=True, help="Serial port to use for transmission")
    parser.add_argument('-prx', '--port_rx', required=False, help="Serial port to use for receiving")
    parser.add_argument('-btx', '--baud_tx', required=False, default=115200, help="Baud rate of transmit port - defaults to 115200")
    parser.add_argument('-brx', '--baud_rx', required=False, default=115200, help="Baud rate of receive port- defaults to 115200")
    parser.add_argument('-o', '--output_path', required=False, help="Path to the .jls output file")

    args = parser.parse_args()

    main(args.image_path, args.width, args.height, args.port_tx, args.port_rx, args.baud_tx, args.baud_rx, args.output_path)