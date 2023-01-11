#!/bin/bash

#SBATCH --job-name=fastqc_20210628_capture
#SBATCH --partition=comp01
#SBATCH --output=fastqc_20210628_capture_%j.txt
#SBATCH --error=fastqc_20210628_capture_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=awijeratne.astate.edu  
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --time=01:00:00

############cluster specific parameters modules#############################
module load java
module load fastqc
export OMP_NUM_THREADS=32




####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/scrfs/storage/awijeratne/Project_results/20210628_capture_analysis/01_Preproprocessing/20210627_filenames.txt"


RAW_DATA=/home/awijeratne/Projects/20210625_sequencing/20210625_capture_seq/raw_data

OUTDIR=$SLURM_SUBMIT_DIR


FASTQC_B_QTRIM=$SLURM_SUBMIT_DIR/fastqc_before_qTRIM
mkdir $FASTQC_B_QTRIM




###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####

#######################################################################################################################
while IFS=" " read -r value1 value2
do {


###################################Raw data#####################################################################

FIRST_SAMPLE_LOC=${RAW_DATA}/${value1}/${value2}_L1_1.fq.gz
SECCOND_SAMPLE_LOC=${RAW_DATA}/${value1}/${value2}_L1_2.fq.gz




####################################Fastqc####################################################################

cd $FASTQC_B_QTRIM

fastqc $FIRST_SAMPLE_LOC --threads 32 --outdir $FASTQC_B_QTRIM
fastqc $SECCOND_SAMPLE_LOC --threads 32 --outdir $FASTQC_B_QTRIM
 


} done <"$file"



