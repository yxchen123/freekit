#!/opt/Anaconda3/2022.05/bin/python
from pymatgen.core.structure import Structure
import os

structure = Structure.from_file("./POSCAR")
#POSCAR中元素的顺序
element_order = list(structure.composition.keys())
element_order_str = [str(i) for i in element_order]
#POSCAR中元素的个数
element_num = [int(i) for i in list(structure.composition.values())]
#POSCAR中元素的个数的字符串形式
element_num_str = [str(i) for i in element_num]

magmom_dict = {"Ru": 3.0, "Ni": 3.0, "Fe": 3.0}
# Ni/Fe/Ru LDH A. P. Sutton, Phys. Rev. B 1998, 57, 1505-1509.
# and Phys. Rev. B 2005, 71, 035105.

magnmom_str = ""

for n, i in enumerate(element_order_str):
    if i in list(magmom_dict.keys()):
        magnmom_str += f"{element_num_str[n]}*{magmom_dict[i]} "
    else:
        magnmom_str += f"{element_num_str[n]}*0.0 "

os.system(f"sed -i 's/^.*MAGMOM =.*/MAGMOM = {magnmom_str}/g' INCAR")
