#!/usr/bin/python3

import os
import sys
from bitarray import bitarray

def ascii2bin(input_file, output_file=None):
    if output_file == None:
        output_file = os.path.splitext(input_file)[0] + ".jls"

    # Delete output file if it already exists
    if os.path.exists(output_file):
        os.remove(output_file)

    # Read ASCII file to binary object
    bits = bitarray()
    with open(input_file, 'r') as ifile:
        for line in ifile:
            bits.extend(line)
    
    # Write binary data to file
    with open(output_file, 'wb') as ofile:
        bits.tofile(ofile)

if __name__=="__main__":
    input_file = sys.argv[1]

    ascii2bin(input_file)