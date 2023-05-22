#!/opt/Anaconda3/2022.05/bin/python
#该脚本用于生产固定原子坐标的POSCAR文件，指定原子编号不去固定，其余原子固定
#主要是用于频率计算中固定slab的原子，以便于计算
import sys
from ase.io import read, write
from ase.constraints import FixAtoms
import os
import numpy as np
from ase import Atoms


def find_folder(target_folder):
    """
    Recursively searches for the target folder, starting from the current directory
    and going up the directory tree until it finds the folder or reaches the root.
    Returns the absolute path of the folder if found, or None if not found.
    """
    # Get the absolute path of the current directory
    current_dir = os.getcwd()

    # Check if the target folder exists in the current directory
    if os.path.exists(os.path.join(current_dir, target_folder)):
        return os.path.abspath(target_folder)

    # Check if we have reached the root directory
    if os.path.abspath(current_dir) == os.path.abspath(os.path.sep):
        return None  # Target folder not found

    # Recursively search in the parent directory
    os.chdir("..")
    return find_folder(target_folder)

work_dir = os.getcwd()
os.chdir(work_dir)
# 读取POSCAR文件
ads_atoms = read(os.path.join('../init_POSCAR'), format='vasp')
ads_atoms_len = len(ads_atoms)
# 读取slab的POSCAR文件
current_dir = os.getcwd()
slab_path = find_folder('slab')
slab_atoms = read(os.path.join(slab_path, 'init_POSCAR'), format='vasp')
slab_atoms_len = len(slab_atoms)
#将ads_atoms和slab_atoms合并
sum_atoms = ads_atoms + slab_atoms
sum_atoms_len = len(sum_atoms)

# 对比atoms和slab_atoms,找到吸附质的原子编号
fixed_atoms = []
for i in range(ads_atoms_len):
    flag = False
    for j in range(ads_atoms_len,sum_atoms_len):
        #考虑周期性边界条件求两个原子的距离
        if sum_atoms.get_distance(i,j,mic=True) <= 0.5:
            flag = True
            break
    if not flag:
        fixed_atoms.append(i)

# 解除需要移动的原子的固定
constraints = FixAtoms(mask=[False if i in fixed_atoms else True for i in range(len(ads_atoms))])
ads_atoms.set_constraint(constraints)

# 输出修改后的POSCAR文件
os.chdir(current_dir)
write('POSCAR_FIX', ads_atoms, format='vasp', vasp5=True, direct=True)
