import cv2
import argparse
import os
from pathlib import Path
    
def ppm_binary_to_ppm_asci(input_file, output_files=None):
    
    if output_files is None:
        path = os.path.dirname(input_file)
        
    elif os.path.isdir(output_files):
        path = output_files
        
    else:
        path = None
        
    if path:
        name = os.path.basename(input_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_file = os.path.join(path, name_wo_ext + "_asci.ppm")

    img = cv2.imread(str(input_file), cv2.IMREAD_COLOR)
    
    # Save the image as PPM with RGB color format
    cv2.imwrite(str(output_file), img, [cv2.IMWRITE_PXM_BINARY, 0])
        
def main():
    
    path = Path("./data_tmp/kodim23.ppm")
    output_path = Path("./data_tmp")
    ppm_binary_to_ppm_asci(path, output_path)
            
if __name__ == "__main__":
    main()