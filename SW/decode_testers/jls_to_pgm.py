import cv2
import argparse
import os
from pathlib import Path
import subprocess
    
def jls_to_pgm(input_file, output_file=None, /, *, size, T=None, bits=None, limit=None):
    
    if output_file is None:
        path = os.path.dirname(input_file)
        
    elif os.path.isdir(output_file):
        path = output_file
        
    else:
        path = None
    
    if path:
        name = os.path.basename(input_file)
        name_wo_ext = os.path.splitext(name)[0]
        output_file = os.path.join(path, name_wo_ext + "_back.pgm")
        
    if T is None:
        T = (3, 7, 21)
        
    if bits is None:
        bits = 8
    
    exec = ["../codec/rawnjl2"]
    exec.append("-d")
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
    
    path = Path("./data_tmp/kodim23_red.jls")
    
    jls_to_pgm(path, size=(512, 768))#, output_path)
    path = Path("./data_tmp/kodim23_blue.jls")
    
    jls_to_pgm(path, size=(512, 768))#, output_path)
    path = Path("./data_tmp/kodim23_green.jls")
    
    jls_to_pgm(path, size=(512, 768))#, output_path)

    # path = Path("./data_tmp/kodim23_redjpeg_ls_dump_back.jls")
    
    # jls_to_pgm(path, size=(512, 768))#, output_path)
    # path = Path("./data_tmp/kodim23_greenjpeg_ls_dump_back.jls")
    
    # jls_to_pgm(path, size=(512, 768))#, output_path)
    # path = Path("./data_tmp/kodim23_bluejpeg_ls_dump_back.jls")
    
    # jls_to_pgm(path, size=(512, 768))#, output_path)
        
if __name__ == "__main__":
    main()