import cv2
import argparse
import os
from pathlib import Path
import subprocess
    
def pgm_to_jlsdump(input_file, output_file=None, /, size=None, T=None, bits=None):
    
    if output_file is None:
        path = os.path.dirname(input_file)
        
    elif os.path.isdir(output_file):
        path = output_file
        
    else:
        path = None
    
    if path:
        name = os.path.basename(input_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_file = os.path.join(path, name_wo_ext + ".jls")
        
    if size is None:
        img = cv2.imread(str(input_file), cv2.IMREAD_GRAYSCALE)
        size = img.shape
        
    if T is None:
        T = (3, 7, 21)
        
    if bits is None:
        bits = 8
        
    exec = ["../codec/rawnjl2"]
    exec.append("-nomarkers")
    exec.append("-noruns")
    exec.append("-rows")
    exec.append(str(size[0]))
    exec.append("-columns")
    exec.append(str(size[1]))
    exec.append("-bits")
    exec.append(str(bits))
    exec.append("-T1")
    exec.append(str(T[0]))
    exec.append("-T2")
    exec.append(str(T[1]))
    exec.append("-T3")
    exec.append(str(T[2]))
    exec.append("-input-file")
    exec.append(str(input_file))
    exec.append("-output-file")
    exec.append(str(output_file))
    exec.append("-input-endian")
    exec.append("big")
    
    process = subprocess.Popen(exec, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    # Get the output and error messages (if any)
    output, error = process.communicate()

    # Print the output and error messages
    print("Output:", output.decode("utf-8"))
    print("Error:", error.decode("utf-8"))
        
        
def main():
    
    path = Path("./data_tmp/kodim23_blue.pgm")
    
    #output_path = Path(".")
    pgm_to_jlsdump(path)#, output_path)
    
    path = Path("./data_tmp/kodim23_red.pgm")
    
    #output_path = Path(".")
    pgm_to_jlsdump(path)#, output_path)
    
    path = Path("./data_tmp/kodim23_green.pgm")
    
    #output_path = Path(".")
    pgm_to_jlsdump(path)#, output_path)
        
if __name__ == "__main__":
    main()