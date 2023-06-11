#!/bin/bash
#An example for MPI job.
#SBATCH -J job_name
#SBATCH -o job-%j.log
#SBATCH -e job-%j.err
#SBATCH -p CPU-64C256GB
#SBATCH -N 3 -n 192
source /etc/profile.d/modules.sh
module purge
module load anaconda/3/22.05_nompi
module load vasp/6.3.2/oneapi_latest
module load optkit
MPIRUN=mpirun #Intel mpi and Open MPI
source alias.sh
shopt -s  expand_aliases
shopt expand_aliases

if [ ! -f init_POSCAR ];then
    cp POSCAR init_POSCAR;
fi
incar;
pre ispin vdw EDIFF_1E-05 EDIFFG_-0.03 NCORE_16;
kpotcar;

#执行VASP
echo "Starting Time is `date`" >>display
echo "Directory is `pwd`" >>display
/opt/bin/optkit/opt_vasp vasp_std;
mv INCAR_best INCAR
$MPIRUN vasp_std >>display
echo "Ending Time is `date`" >>display

#判断当前路径是否包含slab里
if [[ `pwd` != *"slab"* ]]; then
    mkdir zpe;
    cp CONTCAR zpe/POSCAR;
    cp KPOINTS POTCAR INCAR zpe;
    cd zpe;
    pre zpe;
    fix_ads_atoms.py;
    cp POSCAR bak_POSCAR;
    mv POSCAR_FIX POSCAR;
    echo "Starting Time is `date`" >>display
    echo "Directory is `pwd`" >>display
    $MPIRUN vasp_std >>display
    echo "Ending Time is `date`" >>display
    cd ../;
fi

