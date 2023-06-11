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

echo Time is `date`
echo Directory is $PWD
echo This job runs on the following nodes:
echo $SLURM_JOB_NODELIST
echo This job has allocated $SLURM_JOB_CPUS_PER_NODE cpu cores.
MPIRUN=mpirun #Intel mpi and Open MPI
echo "Starting Time is `date`" >display
echo "Directory is `pwd`" >>display
mpirun vasp_std >>display
echo "Ending Time is `date`" >>display

