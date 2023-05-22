#!/bin/bash
source ./config.cfg

#检测${SETUP_PATH}/code有没有被添加到环境变量中
if [ `grep -c "${SETUP_PATH}/code" ~/.bashrc` -eq '1' ]; then
    n=`grep -rin "${SETUP_PATH}/code" ~/.bashrc|awk  -F ':'  '{print $1}'`
    sed -i ""${n}"c  export PATH=${SETUP_PATH}/code:\${PATH}" ~/.bashrc
else
    echo "export PATH=${SETUP_PATH}/code:\$PATH" >> ~/.bashrc
fi

#检测${SETUP_PATH}有没有被添加到环境变量中
if [ `grep -c "${SETUP_PATH}" ~/.bashrc` -eq '1' ]; then
    n=`grep -rin "${SETUP_PATH}" ~/.bashrc|awk  -F ':'  '{print $1}'`
    sed -i ""${n}"c  export PATH=${SETUP_PATH}:\${PATH}" ~/.bashrc
else
    echo "export PATH=${SETUP_PATH}:\${PATH}" >> ~/.bashrc
fi


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
cif_to_vasp="cif_to_vasp='file_format_converter.py *.cif'"
kpotcar="kpotcar='potcar.sh \$(sed -n '6p' POSCAR);(echo 102;echo 2;echo 0.04)|vaspkit'"
alias_list=("$tt" "$potcar" "$kpotcar" "$DFT_U" "$fix_ads_atoms" "$incar" "$DFT_U" "$cif_to_vasp" "$kpotcar")
for i in "${alias_list[@]}";do
    if [ $(grep -c "${i}" ./alias.sh) -eq 1 ]; then
        n=$(grep -rin "${i}" ./alias.sh | awk -F ':' '{print $1}')
        sed -i "${n}c  alias ${i}" ./alias.sh
    else
        echo "alias ${i}" >> ./alias.sh
    fi
done

#检测source alias.sh有没有被添加到~/.bashrc中
if [ `grep -c "source ${SETUP_PATH}/alias.sh" ~/.bashrc` -eq '1' ]; then
    n=`grep -rin "source ${SETUP_PATH}/alias.sh" ~/.bashrc|awk  -F ':'  '{print $1}'`
    sed -i ""${n}"c  source ${SETUP_PATH}/alias.sh" ~/.bashrc
else
    echo "source ${SETUP_PATH}/alias.sh" >> ~/.bashrc
fi

source ~/.bashrc