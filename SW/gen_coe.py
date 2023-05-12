#!/usr/bin/python3
# This program generates a .coe file for RAM/ROM in Vivado
# based on a .ppm image file

import os
import cv2
import argparse
import numpy as np

def main(file_pth, read_width, output_pth):
    # Read image file
    img = cv2.imread(file_pth)

    # Turn into RGB565
        # Extract colors
    blue_img, green_img, red_img = cv2.split(img)
    red_img     = red_img//(2**3)
    green_img   = green_img//(2**2)
    blue_img    = blue_img//(2**3)
        # Change to 16-bit
    red_img     = red_img.astype('uint16')
    green_img   = green_img.astype('uint16')
    blue_img    = blue_img.astype('uint16')
    rgb565_img  = red_img*(2**11) + green_img*(2**5) + blue_img*(2**0)

    # Write .coe file
    if output_pth == None:
        output_pth = os.path.splitext(file_pth)[0] + ".coe"
    
    if read_width == None:
        read_width = 16
    read_width = int(read_width)
    
    with open(output_pth, 'w') as file:
        # Write header
        file.write("memory_initialization_radix=16;\n")
        file.write("memory_initialization_vector=\n")

        # Write data
        missing_bits = read_width
        write_str = ""
        for row in range(rgb565_img.shape[0]):
            for col in range(rgb565_img.shape[1]):
                last_element = ((row==rgb565_img.shape[0]-1) and (col==rgb565_img.shape[1]-1))

                write_str = write_str + f"{rgb565_img[row][col]:04x}"
                missing_bits = missing_bits - 16

                if (missing_bits > 0) and (missing_bits < 16):
                    write_str = write_str + "0"*(missing_bits//4)
                    missing_bits = 0

                if missing_bits == 0:
                    file.write(write_str + (",\n" if not last_element else ";"))
                    missing_bits = 32
                    write_str = ""

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to generate a .coe file for image storage in FPGA RAM/ROM...")
    parser.add_argument('file_pth', help="Path to the .ppm file")
    parser.add_argument('-w', '--read_width', required=False, help="Read/write width of the BRAM")
    parser.add_argument('-o', '--output_pth', required=False, help="Desired output file path")

    args = parser.parse_args()

    main(args.file_pth, args.read_width, args.output_pth)