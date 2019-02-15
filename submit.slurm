#!/bin/bash
#SBATCH --array=1-7
#SBATCH -J SWIFT_hydro_convergence
#SBATCH -N 1
#SBATCH -o logs/out_%j.out
#SBATCH -e logs/err_%j.err
#SBATCH -t 12:00:00
#SBATCH -p cosma6
#SBATCH -A dp004

source shared.sh

if [[ $SLURM_ARRAY_TASK_ID<6 ]]
then 
	scheme="${sph[$SLURM_ARRAY_TASK_ID]}"
else
	index=$((SLURM_ARRAY_TASK_ID-5))
	scheme="${gizmo[$index]}"
fi

cd output/$scheme

for n_part in ${n_particles[@]}
do
	cd n_part
	source run.sh
	cd ..
done


