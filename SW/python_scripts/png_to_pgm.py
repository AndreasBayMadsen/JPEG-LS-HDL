import cv2
import argparse
import os
from pathlib import Path
    
def png_to_pgm(input_file, output_files=None):
    
    if output_files is None:
        path = os.path.dirname(input_file)
        
    elif os.path.isdir(output_files):
        path = output_files
        
    else:
        path = None
        
    if path:
        name = os.path.basename(input_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_files = [os.path.join(path, name_wo_ext + "_red.pgm")]
        output_files.append(os.path.join(path, name_wo_ext + "_green.pgm"))
        output_files.append(os.path.join(path, name_wo_ext + "_blue.pgm"))

    img = cv2.imread(str(input_file), cv2.IMREAD_COLOR)

    # Split the image channels
    b, g, r = cv2.split(img)

    # Save each channel as a PGM file
    cv2.imwrite(str(output_files[2]), b)
    cv2.imwrite(str(output_files[1]), g)
    cv2.imwrite(str(output_files[0]), r)
    
    return img.shape
        
def main():
    
    path = Path("../../kodak_dataset/kodim23.png")
    output_path = Path("./data_tmp")
    png_to_pgm(path, output_path)
        
if __name__ == "__main__":
    main()