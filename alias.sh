#!/bin/bash
alias tt='for i in *;do if [ -d $i ];then mv ${i}.* $i/;cd $i;cif_to_vasp;mv ${i}.vasp POSCAR;cd ..;fi;done'
alias potcar='potcar.sh $(sed -n '6p' POSCAR)'
alias kpotcar='potcar.sh $(sed -n '6p' POSCAR);(echo 102;echo 2;echo 0.04)|vaspkit'
alias DFT_U='DFT+U_from_poscar.py'
alias fix_ads_atoms='fix_ads_atoms.py'
alias incar='cp /home/scms/yxchen/bin/freekit/INCAR ./'
alias tt='for i in *;do if [ -d $i ];then mv ${i}.* $i/;cd $i;cif_to_vasp;mv ${i}.vasp POSCAR;cd ..;fi;done'
alias cif_to_vasp='file_format_converter.py'