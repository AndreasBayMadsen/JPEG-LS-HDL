import cv2
import argparse
import os
from pathlib import Path
import subprocess
from bitarray import bitarray
    
def jlsdump_to_jls(base_file, output_file=None):
    
    if output_file is None:
        path = os.path.dirname(base_file)
        
    elif os.path.isdir(output_file):
        path = output_file
        
    else:
        path = None
    
    if path:
        name = os.path.basename(base_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_file = os.path.join(path, name_wo_ext + ".jls")
        
    name = os.path.basename(base_file)
    name_wo_ext = os.path.splitext(name)[0]
    
    input_files = [os.path.join(path, name_wo_ext + "_redjpeg_ls_dump.txt")]
    input_files.append(os.path.join(path, name_wo_ext + "_greenjpeg_ls_dump.txt"))
    input_files.append(os.path.join(path, name_wo_ext + "_bluejpeg_ls_dump.txt"))
    
    jls_data = bitarray()
    
    with open(input_files[0], "r") as red, open(input_files[1], "r") as green, open(input_files[2], "r") as blue:
        # Read a line from each file
        lines = (red.readline(), green.readline(), blue.readline())
        
        while all(lines):
            for line in lines:
                for char in line:
                    if char in ['1', '0']:
                        jls_data.append(int(char))
                    
            lines = (red.readline(), green.readline(), blue.readline())
    
    # Open the binary file for writing
    with open(output_file, "wb") as f:
        # Write the bit array to the file
        jls_data.tofile(f)
        
def main():
    
    path = Path("./data_tmp/kodim23.ppm")
    
    #output_path = Path(".")
    jlsdump_to_jls(path)#, output_path)
        
if __name__ == "__main__":
    main()