#!/usr/bin/python3
#*******************************************#
# This script is used to interleave the ASCII
# dump of three JPEG-LS compressions into one
#*******************************************#
import argparse

def main(base_name):
    # Determine paths
    red_ascii_pth   = base_name + "_red.txt"
    green_ascii_pth = base_name + "_green.txt"
    blue_ascii_pth  = base_name + "_blue.txt"
    output_path     = base_name + ".txt"

    # Interleave files
    with open(red_ascii_pth, 'r') as red, open(green_ascii_pth, 'r') as green, open(blue_ascii_pth, 'r') as blue, open(output_path, 'w') as out:
        line_combo = [red.readline(), green.readline(), blue.readline()]

        while all(line_combo):
            out.writelines(line_combo)
            line_combo = [red.readline(), green.readline(), blue.readline()]

if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to interleave ASCII files containing JPEG-LS compressions...")
    parser.add_argument('base_name', help="Base name of the encoded ASCII files (without '_red.txt', '_green.txt' and '_red.txt')")

    args = parser.parse_args()

    main(args.base_name)