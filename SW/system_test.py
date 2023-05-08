
import os
import cv2
import glob
import argparse
import numpy as np
from bitarray import bitarray
from pathlib import Path

from python_scripts.png_to_ppm import png_to_ppm
from python_scripts.jls_to_ppm import jls_to_ppm
from transmit_image import transmit_image

def half_round(num, prec):
    mult = num*(10**prec)
    if (mult - np.floor(mult)) >= 0.5:
        return np.ceil(mult)/(10**prec)
    else:
        return np.floor(mult)/(10**prec)

def main(args):

    size = (args.width, args.height)
    
    if os.path.isdir(args.image_path):
        path = Path(args.image_path)
        # Find all .png files in the path
        image_paths = list(path.glob("*.png"))
    else:
        image_paths = [Path(args.image_path)]
        
    print(f"All images: {image_paths}")
    
    for image_path in image_paths:
    
        png_file = Path(image_path)
        
        name = os.path.basename(png_file)
        name_wo_ext = os.path.splitext(name)[0]
        
        # Path to save results in.
        if args.output_path is None:
            output_path = os.path.dirname(png_file)
        else:
            output_path = Path(args.output_path)
        
        ppm_file = os.path.join(output_path, name_wo_ext + ".ppm")
        
        scale=(args.red_bits/8.0, args.green_bits/8.0, args.blue_bits/8.0)
        
        png_to_ppm(png_file, ppm_file, size=size, scale=scale)
        
        jls_file = os.path.join(output_path, name_wo_ext + ".jls")
        
        transmit_image(str(ppm_file), size[0], size[1], args.port_tx, args.port_rx, args.baud_tx, args.baud_rx, str(jls_file))
        
        decoded_ppm_file = os.path.join(output_path, name_wo_ext + "_decode.ppm")
        
        rT = (args.redT1, args.redT2, args.redT3)
        gT = (args.greenT1, args.greenT2, args.greenT3)
        bT = (args.blueT1, args.blueT2, args.blueT3)
        bits = (args.red_bits, args.green_bits, args.blue_bits)
        limits = (args.red_limit, args.green_limit, args.blue_limit)
        
        jls_to_ppm(jls_file, decoded_ppm_file, decoder_path="decode/rawnjl2_decode", size=size, rT=rT, gT=gT, bT=bT, bits=bits, limit=limits)
        
        # Compare two ppm files.
        img1 = cv2.imread(str(ppm_file))
        img2 = cv2.imread(str(decoded_ppm_file))

        # Compare the images
        difference = cv2.subtract(img1, img2)
        result = not cv2.countNonZero(difference)

        # Print the result
        if result:
            # Find compression ratio
            compressed_size = os.path.getsize(jls_file)
            raw_size        = os.path.getsize(ppm_file)*16/24    # Take RGB565 into account
            comp_ratio = half_round(raw_size/compressed_size, 4)
            
            print("Compression success for {png_file = }")
            print(f"Compression ratio: {comp_ratio*100}%")
            
        else:
            raise ValueError(f"The images are not identical for {png_file = }")

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description="Program used to transmit a .ppm image over UART")
    parser.add_argument('image_path', help="Path to the .png image")
    parser.add_argument('-wi', '--width', required=False, default=320, help="Width to resize image")
    parser.add_argument('-hi', '--height', required=False, default=240, help="Height to resize image")
    parser.add_argument('-ptx', '--port_tx', required=True, help="Serial port to use for transmission")
    parser.add_argument('-prx', '--port_rx', required=False, help="Serial port to use for receiving")
    parser.add_argument('-btx', '--baud_tx', required=False, default=115200, help="Baud rate of transmit port - defaults to 115200")
    parser.add_argument('-brx', '--baud_rx', required=False, default=115200, help="Baud rate of receive port- defaults to 115200")
    parser.add_argument('-o', '--output_path', required=False, help="Path with where to keep created files")
    
    parser.add_argument('-rT1', '--redT1', required=False, default=3, help="T1 limit for red")
    parser.add_argument('-rT2', '--redT2', required=False, default=7, help="T2 limit for red")
    parser.add_argument('-rT3', '--redT3', required=False, default=21, help="T3 limit for red")
    parser.add_argument('-gT1', '--greenT1', required=False, default=3, help="T1 limit for green")
    parser.add_argument('-gT2', '--greenT2', required=False, default=7, help="T2 limit for green")
    parser.add_argument('-gT3', '--greenT3', required=False, default=21, help="T3 limit for green")
    parser.add_argument('-bT1', '--blueT1', required=False, default=3, help="T1 limit for blue")
    parser.add_argument('-bT2', '--blueT2', required=False, default=7, help="T2 limit for blue")
    parser.add_argument('-bT3', '--blueT3', required=False, default=21, help="T3 limit for blue")
    parser.add_argument('-rlim', '--red_limit', required=False, default=20, help="Encoding length limit for red")
    parser.add_argument('-glim', '--green_limit', required=False, default=24, help="Encoding length limit for green")
    parser.add_argument('-blim', '--blue_limit', required=False, default=20, help="Encoding length limit for blue")
    parser.add_argument('-rbit', '--red_bits', required=False, default=5, help="Number of bits for red")
    parser.add_argument('-gbit', '--green_bits', required=False, default=6, help="Number of bits for green")
    parser.add_argument('-bbit', '--blue_bits', required=False, default=5, help="Number of bits for blue")
    
    args = parser.parse_args()
    
    main(args)