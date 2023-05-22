#!/bin/bash
args=("$@")
for arg in "${args[@]}"
do  
    if [ $arg == "opt" ];then
        echo "opt"
    elif [ $arg == "zpe" ];then
        sed -i 's/^.*NFREE =.*/NFREE = 2/g' INCAR;
        sed -i 's/^.*POTIM =.*/POTIM = 0.015/g' INCAR;
        sed -i 's/^.*IBRION =.*/IBRION = 5/g' INCAR;
        sed -i 's/^.*EDIFF =.*/EDIFF = 1E-6/g' INCAR;
    elif [ $arg == "scf" ];then
        sed -i 's/^.*NSW =.*/NSW = 0/g' INCAR;
        sed -i 's/^.*IBRION =.*/NFREE = -1/g' INCAR;
        sed -i 's/^.*LWAVE =.*/LWAVE = T/g' INCAR;
        sed -i 's/^.*LCHARG =.*/LCHARG = T/g' INCAR;
    elif [ $arg == "dos" ];then
        sed -i 's/^.*NSW =.*/NSW = 0/g' INCAR;
        sed -i 's/^.*IBRION =.*/NFREE = -1/g' INCAR;
        sed -i 's/^.*LWAVE =.*/LWAVE = T/g' INCAR;
        sed -i 's/^.*LCHARG =.*/LCHARG = T/g' INCAR;
        sed -i 's/^.*ICHARG =.*/ICHARG = 11/g' INCAR;
        sed -i 's/^.*LORBIT =.*/LORBIT = 11/g' INCAR;
        sed -i 's/^.*NEDOS =.*/NEDOS = 2000/g' INCAR;
    elif [ $arg == "elf" ];then
        sed -i 's/^.*PREC =.*/PREC = Accurate/g' INCAR;
        sed -i 's/^.*LELF =.*/LELF = T/g' INCAR;
    elif [ $arg == "wf" ];then
        sed -i 's/^.*LVTOT =.*/PREC = Accurate/g' INCAR;
    elif [ $arg == "dft_u" ];then
        DFT+U_from_poscar.py
    elif [ $arg == "c_nrom" ];then
        sed -i 's/^.*EDIFFG =.*/EDIFFG = -0.03/g' INCAR;
        sed -i 's/^.*EDIFF =.*/EDIFF = 1E-5/g' INCAR;
    elif [ $arg == "c_low" ];then
        sed -i 's/^.*EDIFFG =.*/EDIFFG = -0.05/g' INCAR;
        sed -i 's/^.*EDIFF =.*/EDIFF = 1E-4/g' INCAR;
    elif [ $arg == "c_high" ];then
        sed -i 's/^.*EDIFFG =.*/EDIFFG = -0.01/g' INCAR;
        sed -i 's/^.*EDIFF =.*/EDIFF = 1E-6/g' INCAR;
    else
        echo "Error: $arg is not a valid argument"
        exit 1
    fi
done
