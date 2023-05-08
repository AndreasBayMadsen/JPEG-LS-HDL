import cv2
import argparse
import os
from pathlib import Path
import subprocess
    
def jls_to_ppm(input_file, output_file=None, /, *, size, T=None, bits=None, limit=None):
    
    if output_file is None:
        path = os.path.dirname(input_file)
        
    elif os.path.isdir(output_file):
        path = output_file
        
    else:
        path = None
    
    if path:
        name = os.path.basename(input_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_file = os.path.join(path, name_wo_ext + "_decode.ppm")
        
    if T is None:
        T = (3, 7, 21)
        
    if bits is None:
        bits = (8, 8, 8)
    
    if limit is None:
        limit = (32, 32, 32)
        
    exec = ["../decode/rawnjl2_decode"]
    exec.append("-noruns")
    exec.append("-rows")
    exec.append(str(size[0]))
    exec.append("-columns")
    exec.append(str(size[1]))
    exec.append("-rbits")
    exec.append(str(bits[0]))
    exec.append("-gbits")
    exec.append(str(bits[1]))
    exec.append("-bbits")
    exec.append(str(bits[2]))
    exec.append("-rlimit")
    exec.append(str(limit[0]))
    exec.append("-glimit")
    exec.append(str(limit[1]))
    exec.append("-blimit")
    exec.append(str(limit[2]))
    exec.append("-rT1")
    exec.append(str(T[0]))
    exec.append("-rT2")
    exec.append(str(T[1]))
    exec.append("-rT3")
    exec.append(str(T[2]))
    exec.append("-gT1")
    exec.append(str(T[0]))
    exec.append("-gT2")
    exec.append(str(T[1]))
    exec.append("-gT3")
    exec.append(str(T[2]))
    exec.append("-bT1")
    exec.append(str(T[0]))
    exec.append("-bT2")
    exec.append(str(T[1]))
    exec.append("-bT3")
    exec.append(str(T[2]))
    exec.append("-input-file")
    exec.append(str(input_file))
    exec.append("-output-file")
    exec.append(str(output_file))
    exec.append("-output-endian")
    exec.append("big")
    
    print(" ".join(exec))
    
    process = subprocess.Popen(exec, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    # Get the output and error messages (if any)
    output, error = process.communicate()

    # Print the output and error messages
    print("Output:", output.decode("utf-8"))
    print("Error:", error.decode("utf-8"))
        
        
def main():
    
    path = Path("./data_tmp/kodim23.jls")
    
    #output_path = Path(".")
    jls_to_ppm(path, size=(512, 768))#, output_path)

        
if __name__ == "__main__":
    main()