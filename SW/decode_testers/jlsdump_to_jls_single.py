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
        output_file = os.path.join(path, name_wo_ext + "_back.jls")
        
    name = os.path.basename(base_file)
    name_wo_ext = os.path.splitext(name)[0]
    
    jls_data = bitarray()
    
    with open(base_file, "r") as color:
        # Read a line from each file
        line = color.readline()
        
        while line:
            for char in line:
                if char in ['1', '0']:
                    jls_data.append(int(char))
                    
            line = color.readline()
    
    # Open the binary file for writing
    with open(output_file, "wb") as f:
        # Write the bit array to the file
        jls_data.tofile(f)
        
def main():
    
    path = Path("./data_tmp/kodim23_redjpeg_ls_dump.txt")
    
    #output_path = Path(".")
    jlsdump_to_jls(path)#, output_path)
    
    path = Path("./data_tmp/kodim23_greenjpeg_ls_dump.txt")
    
    #output_path = Path(".")
    jlsdump_to_jls(path)#, output_path)
    
    path = Path("./data_tmp/kodim23_bluejpeg_ls_dump.txt")
    
    #output_path = Path(".")
    jlsdump_to_jls(path)#, output_path)
        
if __name__ == "__main__":
    main()