import cv2
import argparse
import os
import numpy as np
from pathlib import Path
from typing import Tuple
    
def ppm_to_ppm(input_file:str|Path, output_files:str|Path=None, *, scale:Tuple[float, float, float]=None):
    
    if output_files is None:
        path = os.path.dirname(input_file)
        
    elif os.path.isdir(output_files):
        path = output_files
        
    else:
        path = None
        output_file = output_files
        
    if path:
        name = os.path.basename(input_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_file = os.path.join(path, name_wo_ext + "_scaled.ppm")
        
    img = cv2.imread(str(input_file), cv2.IMREAD_UNCHANGED)
    
    if scale is not None:
        rescaled_img = np.zeros_like(img)
        rescaled_img[:,:,0] = img[:,:,0] * scale[0]    # Red channel
        rescaled_img[:,:,1] = img[:,:,1] * scale[1]    # Green channel
        rescaled_img[:,:,2] = img[:,:,2] * scale[2]    # Blue channel
        
        img = rescaled_img
    
    # Save the image as PPM with RGB color format
    cv2.imwrite(str(output_file), img, [cv2.IMWRITE_PXM_BINARY, 0])
        
def main():
    
    path = Path("../../data_tmp/kodim23.ppm")
    output_path = Path("../../data_tmp/kodim23_rescaled.ppm")
    ppm_to_ppm(path, output_path, scale=(2 ** (8.0 - 5.0), 2 ** (8.0 - 6.0), 2 ** (8.0 - 5.0)))
        
if __name__ == "__main__":
    main()