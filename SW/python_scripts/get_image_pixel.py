#!/usr/bin/python3
#*******************************************#
# This script takes in an image file and returns
# the RGB565 value for the red color of a given
# pixel
#*******************************************#
import os
import cv2
import argparse
import numpy as np

def main(input_file, mode, row, column, number):
    # Load the image
    if os.path.splitext(input_file)[1]==".pgm":                 # In case of '.pgm' file
        color = cv2.imread(input_file, cv2.IMREAD_GRAYSCALE)    # NOTE: It is assumed that it has the right bit-depth
        result=[f"{val:d}" for val in color[row, column:column+number]] # Format in decimal
    else:
        img = cv2.imread(input_file)
        blue, green, red = cv2.split(img)

        # Calculate RGB565 values
        red   = red // 8
        green = green // 4
        blue  = blue // 8

        if mode=="R5":
            color = red
            result=[f"{val:d}" for val in color[row, column:column+number]] # Format in decimal
        else:
            red     = red.astype('uint16')
            green   = green.astype('uint16')
            blue    = blue.astype('uint16')
            color = red*(2**11) + green*(2**5) + blue*(2**0)
            result=[f"{val:x}" for val in color[row, column:column+number]] # Format in hexadecimal

    # Print desired value
    print(result)

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used get the red color value of an image pixel...")
    parser.add_argument('input_file', help="Path of the image")
    parser.add_argument('-m', '--mode', help="Mode of operation", required=True, choices=["RGB565", "R5"])
    parser.add_argument('-r', '--row', help="Row number of the pixel", required=True)
    parser.add_argument('-c', '--column', help="Column number of the pixel", required=True)
    parser.add_argument('-n', '--number', help="Number of pixels to get", required=False, default=1)

    args = parser.parse_args()

    main(args.input_file, args.mode, int(args.row), int(args.column), int(args.number))