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


mkdir scf;
cp CONTCAR POTCAR KPOINTS INCAR scf/;
cd scf;
mv CONTCAR POSCAR;

pre kd scf;
#执行VASP
echo "Starting Time is `date`" >>display
echo "Directory is `pwd`" >>display
$MPIRUN vasp_std >>display
echo "Ending Time is `date`" >>display

mkdir dos;
cp CHGCAR WAVECAR INCAR KPOINTS POSCAR POTCAR dos/;
cd dos;
pre dos;
echo "Starting Time is `date`" >>display
echo "Directory is `pwd`" >>display
$MPIRUN vasp_std >>display
echo "Ending Time is `date`" >>display
