#!/bin/bash
source ./config.cfg

#检测${SETUP_PATH}/code有没有被添加到环境变量中
if [ `grep -c "${SETUP_PATH}/code" ~/.bashrc` -eq '1' ]; then
    n=`grep -rin "${SETUP_PATH}/code" ~/.bashrc|awk  -F ':'  '{print $1}'`
    sed -i ""${n}"c  export PATH=${SETUP_PATH}/code:\${PATH}" ~/.bashrc
else
    echo "export PATH=${SETUP_PATH}/code:\$PATH" >> ~/.bashrc
fi

source ~/.bashrc

#将code文件夹中的py脚本的编译器更改$PYTHON_PATH
cd code;
for i in *.py; do
    sed -i "1s~.*~#!${PYTHON_PATH}~g" ${i}
done
cd ..;


#配置alias
tt="tt='for i in *;do if [ -d \$i ];then mv \${i}.* \$i/;cd \$i;cif_to_vasp;mv \${i}.vasp POSCAR;cd ..;fi;done'"
potcar="potcar='potcar.sh \$(sed -n '6p' POSCAR)'"
kpotcar="kpotcar='potcar.sh \$(sed -n '6p' POSCAR);(echo 102;echo 2;echo 0.04)|vaspkit'"
fix_ads_atoms="fix_ads_atoms='fix_ads_atoms.py'"
incar="incar='cp ${SETUP_PATH}/INCAR ./'"
DFT_U="DFT_U='DFT+U_from_poscar.py'"
alias_list=("$tt" "$potcar" "$kpotcar" "$DFT_U" "$fix_ads_atoms" "$incar")
for i in "${alias_list[@]}"; do
    if [ $(grep -c "${i}" ~/.bashrc) -eq 1 ]; then
        n=$(grep -rin "${i}" ~/.bashrc | awk -F ':' '{print $1}')
        sed -i "${n}c  alias ${i}" ~/.bashrc
    else
        echo "alias ${i}" >> ~/.bashrc
    fi
done