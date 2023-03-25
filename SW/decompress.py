#!/usr/bin/python3
# This program decompresses a JPEG-LS compressed image,
# where each color (R, G and B) is represented by an
# ASCII file containing the Golomb codes.
# NOTE: The three files should have the same base name,
#           the only difference being the postfix '_red.txt'
#           '_green.txt' and '_blue.txt'

import os
import sys
import cv2
import argparse
import numpy as np
from python_scripts.ascii2bin import ascii2bin

def half_round(num, prec):
    mult = num*(10**prec)
    if (mult - np.floor(mult)) >= 0.5:
        return np.ceil(mult)/(10**prec)
    else:
        return np.floor(mult)/(10**prec)

def main(base_name: str, rows, cols, analyze, original_pth):
    red_ascii_pth   = base_name + "_red.txt"
    green_ascii_pth = base_name + "_green.txt"
    blue_ascii_pth  = base_name + "_blue.txt"

    red_bin_pth     = base_name + "_red.jls"
    green_bin_pth   = base_name + "_green.jls"
    blue_bin_pth    = base_name + "_blue.jls"

    red_pgm_pth     = base_name + "_red.pgm"
    green_pgm_pth   = base_name + "_green.pgm"
    blue_pgm_pth    = base_name + "_blue.pgm"

    ppm_pth         = base_name + ".ppm"

    # Convert ASCII files to bitstreams
    ascii2bin(red_ascii_pth, red_bin_pth)
    ascii2bin(green_ascii_pth, green_bin_pth)
    ascii2bin(blue_ascii_pth, blue_bin_pth)

    # Decompress bitstreams individually
    exe_pth = os.path.join(os.path.dirname(__file__), "codec", "rawnjl2")
    os.system(exe_pth # Red
              + f" -d -nomarkers -noruns -rows {rows} -columns {cols} -bits 5 -T1 3 -T2 7 -T3 21"
              + f" -input-file {red_bin_pth}"
              + f" -output-file {red_pgm_pth} -output-endian big")
    os.system(exe_pth # Green
              + f" -d -nomarkers -noruns -rows {rows} -columns {cols} -bits 6 -T1 3 -T2 7 -T3 21"
              + f" -input-file {green_bin_pth}"
              + f" -output-file {green_pgm_pth} -output-endian big")
    os.system(exe_pth # Blue
              + f" -d -nomarkers -noruns -rows {rows} -columns {cols} -bits 5 -T1 3 -T2 7 -T3 21"
              + f" -input-file {blue_bin_pth}"
              + f" -output-file {blue_pgm_pth} -output-endian big")
    
    # Combine colors
    decomp_red      = cv2.imread(red_pgm_pth, cv2.IMREAD_GRAYSCALE)*(2**3)
    decomp_green    = cv2.imread(green_pgm_pth, cv2.IMREAD_GRAYSCALE)*(2**2)
    decomp_blue     = cv2.imread(blue_pgm_pth, cv2.IMREAD_GRAYSCALE)*(2**3)
    decomp_rgb      = np.dstack((decomp_blue, decomp_green, decomp_red))

    # Save final image
    cv2.imwrite(ppm_pth, decomp_rgb)

    # Analyze results
    if analyze:
        # Verify correct compression/decompression
        success = True
        if original_pth != None:
            # Load image and split into colors
            orig = cv2.imread(original_pth)
            orig_blue, orig_green, orig_red = cv2.split(orig)

            # Quantize to RGB565
            orig_red    = (orig_red//(2**3))*(2**3)
            orig_green  = (orig_green//(2**2))*(2**2)
            orig_blue   = (orig_blue//(2**3))*(2**3)

            success = ((orig_red==decomp_red).all() and (orig_green==decomp_green).all() and (orig_blue==decomp_blue).all())

        # Find compression ratio
        compressed_size = os.path.getsize(red_bin_pth) + os.path.getsize(green_bin_pth) + os.path.getsize(blue_bin_pth)
        raw_size        = os.path.getsize(ppm_pth)*16/24    # Take RGB565 into account
        comp_ratio = half_round(raw_size/compressed_size, 4)

        # Print results
        if not success:
            print("Decompressed image differs from original!")
        else:
            print("Compression success")
            print(f"Compression ratio: {comp_ratio*100}%")

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to decompress and analyze the results of the HDL JPEG-LS compression...")
    parser.add_argument('base_name', help="Base name of the encoded color files")
    parser.add_argument('-r', '--rows', help="Number of rows im image", required=True)
    parser.add_argument('-c', '--columns', help="Number of columns in image", required=True)
    parser.add_argument('--analyze', action='store_true', required=False, help="Analyze results")
    parser.add_argument('-o', '--original', required=False, help="Path to original image for analysis")

    args = parser.parse_args()

    main(args.base_name, args.rows, args.columns, args.analyze, args.original)