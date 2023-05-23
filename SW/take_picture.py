#!/usr/bin/python3
# This program signals to the system to take a picture
# with the camera, compress it and send it over UART.
# The bitstream is then received and decompressed into an image

import serial
import argparse
from transmit_image import receive_image
from python_scripts.jls_to_ppm import jls_to_ppm
from python_scripts.ppm_to_ppm import ppm_to_ppm

def main(output_path, width, height, port_tx, port_rx, baud_tx, baud_rx):
    ser_tx = serial.Serial(port_tx, baud_tx,
                        serial.EIGHTBITS,
                        serial.PARITY_NONE,
                        serial.STOPBITS_ONE,
                        timeout=5)
    
    # Send start signal
    ser_tx.write(bytearray(1))
    ser_tx.close()

    # Receive bitstream
    expected_size = width*height*3*8
    jls_path = output_path + ".jls"
    receive_image(port_rx, baud_rx, jls_path, expected_size)

    # Decompress bitstream
    ppm_path = output_path + ".ppm"
    rT = (3, 7, 21)
    gT = (3, 7, 21)
    bT = (3, 7, 21)
    bits = (5, 6, 5)
    limits = (20, 24, 20)
    jls_to_ppm(jls_path, ppm_path, decoder_path="decode/rawnjl2_decode", size=(width, height), rT=rT, gT=gT, bT=bT, bits=bits, limit=limits)

    # Rescale image colours
    rescaled_ppm_path = output_path + "_rescaled.ppm"
    scale=(2**(8.0 - bits[0]), 2**(8.0 - bits[1]), 2**(8.0 - bits[2]))
    ppm_to_ppm(ppm_path, rescaled_ppm_path, scale=scale)

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to take an image and process the received bitstream...")
    parser.add_argument('output_path', help="Path to store the outputs in, including filename without extension")
    parser.add_argument('-wi', '--width', required=False, default=320, help="Width of image")
    parser.add_argument('-hi', '--height', required=False, default=240, help="Height of image")
    parser.add_argument('-ptx', '--port_tx', required=True, help="Serial port to use for transmission")
    parser.add_argument('-prx', '--port_rx', required=True, help="Serial port to use for receiving")
    parser.add_argument('-btx', '--baud_tx', required=False, default=115200, help="Baud rate of transmit port - defaults to 115200")
    parser.add_argument('-brx', '--baud_rx', required=False, default=115200, help="Baud rate of receive port- defaults to 115200")

    args = parser.parse_args()

    main(args.output_path, int(args.width), int(args.height), args.port_tx, args.port_rx, int(args.baud_tx), int(args.baud_rx))