#!/usr/bin/python3
# This program generates a .coe file for RAM/ROM in Vivado
# based on a .ppm image file

import os
import cv2
import argparse

def main(file_pth, output_pth):
    # Read image file
    img = cv2.imread(file_pth)

    # Turn into RGB565
    blue_img, green_img, red_img = cv2.split(img)
    red_img     = red_img//(2**3)
    green_img   = green_img//(2**2)
    blue_img    = blue_img//(2**3)
    rgb565_img  = red_img*(2**11) + green_img*(2**5) + blue_img*(2**0)

    # Write .coe file
    if output_pth == None:
        output_pth = os.path.splitext(file_pth)[0] + ".coe"
    
    with open(output_pth, 'w') as file:
        # Write header
        file.write("memory_initialization_radix=16;\n")
        file.write("memory_initialization_vector=\n")

        # Write data
        for row in range(rgb565_img.shape[0]):
            for col in range(rgb565_img.shape[1]):
                last_element = ((row==rgb565_img.shape[0]-1) and (col==rgb565_img.shape[1]-1))
                file.write(f"{rgb565_img[row][col]:x}" + (",\n" if not last_element else ";"))

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to generate a .coe file for image storage in FPGA RAM/ROM...")
    parser.add_argument('file_pth', help="Path to the .ppm file")
    parser.add_argument('-o', '--output_pth', required=False, help="Desired output file path")

    args = parser.parse_args()

    main(args.file_pth, args.output_pth)