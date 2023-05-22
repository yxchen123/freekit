#!/opt/Anaconda3/2022.05/bin/python
import sys
import os
from pymatgen.core import Structure
from pymatgen.io.cif import CifWriter
from pymatgen.io.vasp.outputs import Poscar

def convert_file_format(file_path):
    # 判断文件类型
    file_name, file_extension = os.path.splitext(file_path)
    output_dir = os.path.dirname(file_path)
    if file_extension == '.cif':
        # 将cif转换为POSCAR格式
        structure = Structure.from_file(file_path)
        poscar_path = os.path.join(output_dir, file_name + '.vasp')
        poscar = Poscar(structure)
        poscar.write_file(poscar_path)
        return poscar_path
    elif file_extension == '.vasp' or file_extension == '.vesta' or file_extension == '':
        # 将POSCAR格式转换为cif格式
        poscar = Poscar.from_file(file_path)
        cif_path = os.path.join(output_dir, file_name + '.cif')
        structure = poscar.structure
        cif_writer = CifWriter(structure)
        cif_writer.write_file(cif_path)
        return cif_path
    else:
        raise ValueError("Unsupported file format.")

work_dir = os.getcwd()
os.chdir(work_dir)
# 从命令行参数获取文件路径
file_path = sys.argv[1]

# 执行文件格式转换
converted_file_path = convert_file_format(file_path)

print("Converted file path:", converted_file_path)