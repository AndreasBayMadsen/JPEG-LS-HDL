#!/usr/bin/python3
#*******************************************#
# This script turns a '.jls' binary file into
# a corresponding ASCII file where each bit
# is written as a '0' or '1'
#*******************************************#
import os
import argparse
from bitarray import bitarray

def main(input_file):
    # Determine output path
    output_file = os.path.splitext(input_file)[0] + ".txt"

    # Read binary file
    bits = bitarray()
    with open(input_file, 'rb') as jls:
        bits.fromfile(jls)
    
    # Write as ASCII to file
    with open(output_file, 'w') as txt:
        txt.write(bits.to01())

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to turn a '.jls' file into a corresponding ASCII file...")
    parser.add_argument('input_file', help="Path of the '.jls' file")

    args = parser.parse_args()

    main(args.input_file)