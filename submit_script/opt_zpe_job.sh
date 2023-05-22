#!/bin/sh
#An example for MPI job.
#SBATCH -J job_name
#SBATCH -o job-%j.log
#SBATCH -e job-%j.err
#SBATCH -N 2 -n 80
#SBATCH -p CPU-Shorttime --qos=qos_cpu_shorttime

source alias.sh
shopt -s  expand_aliases
shopt expand_aliases

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
module purge
module load vasp/6.1.0/hpcx-intel-2019.update5-cuda-10.2.89
module load hpcx/2.9.0/hpcx-intel-2019.update5
MPIRUN=mpirun #Intel mpi and Open MPI

for i in *;do
    if [ ! -d $i ];then
        continue;
    fi
    cd $i;
    (echo 102;echo 2;echo 0.04)|vaspkit;
    incar;
    if [ ! -f init_POSCAR ];then
        cp POSCAR init_POSCAR;
    fi
    #执行VASP
    echo "Starting Time is `date`" >>display
    echo "Directory is `pwd`" >>display
    $MPIRUN vasp_std >>display
    echo "Ending Time is `date`" >>display


    if [ $i != 'slab' ];then
        mkdir zpe;
        cp CONTCAR zpe/POSCAR;
        cp KPOINTS POTCAR INCAR zpe;
        cd zpe;
        cp ~/bin/fix_ads_atoms.py ./;
        sed -i 's/^.*NFREE =.*/NFREE = 2/g' INCAR;
        sed -i 's/^.*IBRION =.*/IBRION = 5/g' INCAR;
        sed -i 's/^.*POTIM =.*/POTIM = 0.015/g' INCAR;
        sed -i 's/^.*NCORE =.*/#NCORE/g' INCAR;
        python fix_ads_atoms.py;
        cp POSCAR bak_POSCAR;
        mv POSCAR_FIX POSCAR;
        echo "Starting Time is `date`" >>display
        echo "Directory is `pwd`" >>display
        $MPIRUN vasp_std >>display
        echo "Ending Time is `date`" >>display
        cd ../;
    fi
    cd ../;
done