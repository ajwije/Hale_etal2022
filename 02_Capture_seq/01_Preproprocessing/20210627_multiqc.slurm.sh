#!/bin/bash

#SBATCH --job-name=multiqc_20210627_methData
#SBATCH --partition=comp06
#SBATCH --output=multiqc_20210627_methData_%j.txt
#SBATCH --error=multiqc_20210627_methData_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=awijeratne.astate.edu  
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=04:00:00

############cluster specific parameters modules#############################

module load python/3.7.3-anaconda
source /share/apps/bin/conda-3.7.3.sh

conda activate Multiqc

cd /scratch/$SLURM_JOB_ID/




####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################


####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################


A_Q_T=$SLURM_SUBMIT_DIR/FASTQ_After_BBQ_Trim

cd $A_Q_T
multiqc ./ 


FASTQC_B_QTRIM=$SLURM_SUBMIT_DIR/fastqc_before_qTRIM

cd $FASTQC_B_QTRIM

multiqc ./ 

conda deactivate


