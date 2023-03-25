#!/usr/bin/python3
import cv2
import sys

def main(filename: str):
    # Load image
    img = cv2.imread(filename + ".ppm")
    blue, green, red = cv2.split(img)

    # Reduce bit depth
    red   = red // 8
    green = green // 4
    blue  = blue // 8

    # Save image components
    cv2.imwrite(filename + "_red.pgm", red)
    cv2.imwrite(filename + "_green.pgm", green)
    cv2.imwrite(filename + "_blue.pgm", blue)

if __name__=="__main__":
    filename = sys.argv[1]
    main(filename)