#!/usr/bin/python3

import os
import sys
from bitarray import bitarray

def main(input_file: str):
    input_file_pth  = input_file + ".txt"
    output_file_pth = input_file + ".jls"

    # Delete output file if it already exists
    if os.path.exists(output_file_pth):
        os.remove(output_file_pth)

    # Read ASCII file to binary object
    bits = bitarray()
    with open(input_file_pth, 'r') as ifile:
        for line in ifile:
            bits.extend(line)
    
    # Write binary data to file
    with open(output_file_pth, 'wb') as ofile:
        bits.tofile(ofile)

if __name__=="__main__":
    input_file = sys.argv[1]

    main(input_file)