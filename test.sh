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
        continue;
    elif [ $arg == "dos" ];then
        continue;
    elif [ $arg == "elf" ];then
        continue;
    elif [ $arg == "wf" ];then
        continue;
    elif [ $arg == "default" ];then
        break;
    else
        echo "Error: $arg is not a valid argument"
        exit 1
    fi
done
