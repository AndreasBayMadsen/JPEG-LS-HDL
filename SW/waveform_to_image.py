#!/usr/bin/python3
# This program takes a waveform of the OV7670 data signals and turns it
# into an image file.
# NOTE: Only the first frame in the file will be analyzed

import os
import csv
import cv2
import argparse
import numpy as np

def main(input_file_name, output_file_name, flip_vsync):
    # Determine output path if not specified
    if output_file_name == None:
        output_file_name = os.path.splitext(input_file_name)[0] + ".ppm"

    # Prepare variables
    fsm_state = 'IDLE'
    high_byte = True

    N_col = 0
    N_row = 0
    image_row = np.zeros(0)
    image = np.zeros(0)
    current_col = 0
    current_row = 0
    current_pixel = 0

    pclk_shift = [0, 0]
    vsync_shift = [0, 0, 0, 0]
    href_shift = [0, 0]
    
    # Analyze the file
    with open(input_file_name, 'r') as input_file:
        reader = csv.reader(input_file)

        for csv_line_num, csv_line in enumerate(reader):
            if csv_line_num <= 6:    # Skip header
                pass
            elif csv_line_num == 7: # Read field names
                time_idx = [idx for idx, el in enumerate(csv_line) if el=="Time (s)"][0]
                pclk_idx = [idx for idx, el in enumerate(csv_line) if el=="pclk"][0]
                pixel_idx = [idx for idx, el in enumerate(csv_line) if el=="pixel"][0]
                href_idx = [idx for idx, el in enumerate(csv_line) if el=="href"][0]
                vsync_idx = [idx for idx, el in enumerate(csv_line) if el=="vsync"][0]
            else:   # Read data
                # Get signal values
                time = float(csv_line[time_idx])
                pclk = int(csv_line[pclk_idx])
                pixel = int(csv_line[pixel_idx])
                href = int(csv_line[href_idx])
                vsync = int(csv_line[vsync_idx])

                # Invert VSYNC if required
                if flip_vsync:
                    if vsync==1:
                        vsync=0
                    else:
                        vsync=1

                # Shift registers
                pclk_shift = [pclk_shift[1], pclk]

                # Algorithm
                if pclk_shift==[0, 1]:
                    # Shift registers
                    vsync_shift = [vsync_shift[1], vsync_shift[2], vsync_shift[3], vsync]
                    href_shift = [href_shift[1], href]

                    match fsm_state:
                        case 'IDLE':
                            if vsync_shift==[1, 1, 0, 0]:
                                fsm_state = 'RUNNING'
                        
                        case 'RUNNING':
                            if href==1:                 # In row
                                if high_byte:
                                    current_pixel = pixel*(2**8)
                                    high_byte = False
                                else:
                                    current_pixel = current_pixel + pixel*(2**0)

                                    if image.size == 0:  # If first row
                                        image_row = np.append(image_row, current_pixel)
                                        current_col = current_col+1
                                    elif current_col < N_col:
                                        image_row[current_col] = current_pixel
                                        current_col = current_col+1

                                    high_byte = True
                            elif href_shift == [1, 0]:  # End of row
                                if image.size == 0:
                                    N_col = current_col
                                    image = image_row
                                else:
                                    image = np.vstack((image, image_row))

                                image_row = np.zeros(image_row.shape)

                                current_row = current_row + 1
                                current_col = 0
                            elif vsync_shift==[0, 0, 1, 1]:
                                break

    # Convert into separate colors
    red_image   = np.zeros(image.shape)
    green_image = np.zeros(image.shape)
    blue_image  = np.zeros(image.shape)

    for row_idx, row in enumerate(image):
        for col_idx, val in enumerate(row):
            # Extract individual RGB565 components
            red_val     = val//(2**11)
            green_val   = (val-red_val*(2**11))//(2**5)
            blue_val    = (val-red_val*(2**11)-green_val*(2**5))//(2**0)

            # Rescale to 8-bit and store individually
            red_image[row_idx, col_idx]     = red_val*(2**3)
            green_image[row_idx, col_idx]   = green_val*(2**2)
            blue_image[row_idx, col_idx]    = blue_val*(2**3)

    # Combine into 24-bit RGB image
    image_rgb = np.dstack((blue_image, green_image, red_image))

    # Save final image
    cv2.imwrite(output_file_name, image_rgb)


if __name__=="__main__":
    # Run argument parser
    parser = argparse.ArgumentParser(description="Program used to turn OV7670 waveform data into images...")
    parser.add_argument('input_file_name', help="Name of the input .csv file")
    parser.add_argument('-o', '--output_file_name', required=False, help="Path to the output file")
    parser.add_argument('-fv', '--flip_vsync', action='store_true', required=False, help="Invert the VSYNC signal")

    args = parser.parse_args()

    main(args.input_file_name, args.output_file_name, args.flip_vsync)