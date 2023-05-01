from pathlib import Path
import os
import cv2

from png_to_pgm import png_to_pgm
from pgm_to_jlsdump import pgm_to_jlsdump
from jlsdump_to_jls import jlsdump_to_jls
from jls_to_ppm import jls_to_ppm


def main(input_file, output_folder):
    
    name = os.path.basename(input_file)
    name_wo_ext = os.path.splitext(name)[0]
    
    path = Path("../../kodak_dataset/kodim23.png")
    output_path = Path(output_folder)
    size = png_to_pgm(input_file, output_path)
    
    print(size)
    
    path = os.path.join(output_folder, name_wo_ext + "_red.pgm")    
    pgm_to_jlsdump(path)
    path = os.path.join(output_folder, name_wo_ext + "_blue.pgm")    
    pgm_to_jlsdump(path)
    path = os.path.join(output_folder, name_wo_ext + "_green.pgm")    
    pgm_to_jlsdump(path)
    
    path = os.path.join(output_folder, name_wo_ext + ".png")
    jlsdump_to_jls(path)
    
    path = os.path.join(output_folder, name_wo_ext + ".jls") 
    jls_to_ppm(path, size=size)


if __name__ == "__main__":
    main(Path("../../kodak_dataset/kodim23.png"), Path("./data_tmp"))
