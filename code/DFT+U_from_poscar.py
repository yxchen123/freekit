#PYTHON_PATH
from pymatgen.core.structure import Structure
import os

structure = Structure.from_file("./POSCAR")
#POSCAR中元素的顺序
element_order = list(structure.composition.keys())
element_order_str = [str(i) for i in element_order]
DFT_U_dict = {"Ru": 2.5, "Ni": 6.6, "Fe": 3.5, "Cu": 4.0}
# Ni/Fe/Ru LDH A. P. Sutton, Phys. Rev. B 1998, 57, 1505-1509.
# and Phys. Rev. B 2005, 71, 035105.

LDAUU_str = ""
LDAUL_str = ""
LDAUJ_str = ""
for i in element_order_str:
    if i in list(DFT_U_dict.keys()):
        LDAUU_str += str(DFT_U_dict[i]) + " "
        LDAUL_str += "2 "
        LDAUJ_str += "0 "
    else:
        LDAUU_str += "0 "
        LDAUL_str += "-1 "
        LDAUJ_str += "0 "

os.system("sed -i 's/^.*LDAU =.*/LDAU = .TRUE./g' INCAR")
os.system("sed -i 's/^.*LDAUTYPE =.*/LDAUTYPE = 2/g' INCAR")
os.system(f"sed -i 's/^.*LDAUL =.*/LDAUL = {LDAUL_str}/g' INCAR")
os.system("sed -i 's/^.*LDAUPRINT =.*/LDAUPRINT = 1/g' INCAR")
os.system(f"sed -i 's/^.*LDAUU =.*/LDAUU = {LDAUU_str}/g' INCAR")
os.system(f"sed -i 's/^.*LDAUJ =.*/LDAUJ = {LDAUJ_str}/g' INCAR")
os.system("sed -i 's/^.*LMAXMIX =.*/LMAXMIX = 4/g' INCAR")
os.system("sed -i 's/^.*LASPH =.*/LASPH=  .TRUE./g' INCAR")
