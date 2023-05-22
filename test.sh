#!/bin/bash
tt='for i in *;do if [ -d $i ];then mv ${i}.* $i/;cd $i;cif_to_vasp;mv ${i}.vasp POSCAR;cd ..;fi;done'
potcar="potcar.sh \$(sed -n '6p' POSCAR)"
kpotcar="potcar.sh \$(sed -n '6p' POSCAR);(echo 102;echo 2;echo 0.04)|vaspkit"
fix_ads_atoms="fix_ads_atoms.py"
incar="cp \${SETUP_PATH}/INCAR ./"

alias_list=("$tt" "$potcar" "$kpotcar" "$DFT_U" "$fix_ads_atoms" "$incar")
for i in "${alias_list[@]}"; do
    if [ $(grep -c "${i}" ~/.bashrc) -eq 1 ]; then
        n=$(grep -rin "${i}" ~/.bashrc | awk -F ':' '{print $1}')
        sed -i "${n}c  alias ${i}" ~/.bashrc
    else
        echo "alias ${i}" >> ~/.bashrc
    fi
done
