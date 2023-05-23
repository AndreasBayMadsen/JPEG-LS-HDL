#!/usr/bin/python3
#*******************************************#
# This script crops on or more images to a
# specified size
#*******************************************#
from pathlib import Path
import argparse
import cv2
import os

def main(input_path, start_row, start_col, width, height, output_path):
    # Determine input
    if os.path.isdir(input_path):   # In case of directory specified
        image_paths = list(Path(input_path).glob("*.png"))
        image_paths = [str(x) for x in image_paths]
    else:                           # In case of image specified
        image_paths = [input_path]

    # Determine output
    if output_path == None:
        output_path = input_path

    # Crop images
    for image_path in image_paths:
        image = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)                    # Load image
        image = image[start_row:start_row+height, start_col:start_col+width]    # Crop image

        # Determine output path
        split_path = os.path.splitext(os.path.basename(image_path))
        output_file = os.path.join(output_path, split_path[0] + "_cropped" + split_path[1])
        cv2.imwrite(output_file, image)

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to crop one or more images to a specified size...")
    parser.add_argument('input_path', help="Path of the input file or directory in which multiple images reside")
    parser.add_argument('-x', '--start_row', help="First row to include in the cropped image", required=True)
    parser.add_argument('-y', '--start_col', help="First column to include in the cropped image", required=True)
    parser.add_argument('-wi', '--width', help="Desired width of the image", required=True)
    parser.add_argument('-hi', '--height', help="Desired height of the image", required=True)
    parser.add_argument('-o', '--output_path', help="Directory to store the cropped image(s) in", required=False)

    args = parser.parse_args()

    main(args.input_path, int(args.start_row), int(args.start_col), int(args.width), int(args.height), args.output_path)