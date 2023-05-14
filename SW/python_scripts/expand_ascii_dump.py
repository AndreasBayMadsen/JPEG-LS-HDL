#!/usr/bin/python3
#*******************************************#
# This script compares an ASCII dump of a
# compression where all bits are written in one
# line with a reference where they are written
# on individual lines.
# It then splits the codes into individual lines
# in the target file for as long as it agrees
# with the reference
#*******************************************#
import os
import argparse

def main(input_file, reference_file, output_file):
    # Determine output file name
    if output_file==None:
        split_input_path = os.path.splitext(input_file)
        output_file = split_input_path[0] + "_split" + split_input_path[1] 
    pass

    with open(input_file, 'r') as input, open(reference_file, 'r') as reference, open(output_file, 'w') as output:
        reference_line = reference.readline().replace('\n', '')
        input_line = input.read(len(reference_line))

        while reference_line and input_line:
            if input_line==reference_line:  # Codes mathc
                output.write(input_line+"\n")
            else:                           # Codes differ
                output.write(input_line + "  #  " + reference_line + "\n")

            reference_line = reference.readline().replace('\n', '')
            input_line = input.read(len(reference_line))

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to split ASCII Golomb codes into lines based on a reference file...")
    parser.add_argument('input_file', help="Path of the input file")
    parser.add_argument('reference_file', help="Path of the reference file")
    parser.add_argument('-o', '--output_file', help="Path of the input file", required=False, default=None)

    args = parser.parse_args()

    main(args.input_file, args.reference_file, args.output_file)