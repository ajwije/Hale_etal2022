#!/bin/bash

#SBATCH --job-name=bbduk_0210628_capture
#SBATCH --partition=comp06
#SBATCH --output=bbduk_0210628_capture_%j.txt
#SBATCH --error=bbduk_0210628_capture_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=awijeratne.astate.edu  
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=04:00:00

############cluster specific parameters modules#############################

export OMP_NUM_THREADS=24
module load bbmap/38.82

module load java
module load fastqc

cd /local_scratch/$SLURM_JOB_ID/




####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################


####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/scrfs/storage/awijeratne/Project_results/20210628_capture_analysis/01_Preproprocessing/20210627_filenames.txt"


RAW_DATA=/home/awijeratne/Projects/20210625_sequencing/20210625_capture_seq/raw_data



QTRIM_DATA=$SLURM_SUBMIT_DIR



ADP_REM_BB=$QTRIM_DATA/BB_Adapter_Removed


mkdir $ADP_REM_BB

A_Q_T=$QTRIM_DATA/FASTQ_After_BBQ_Trim
mkdir $A_Q_T

###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####
FASTQ_TYPE="sanger"
#minmum quality score
QUALIY_THRESHOLD=20
#This is the minimum read length after trimming. 
MIN_LENGTH=50
#reads will be trimmed to 100bp
#TRIM_LENTH=100


ADADPTER_SEQ=/scrfs/storage/awijeratne/home/Projects/20210504_sequencing/01_Preproprocessing/adapter.fa

#conda activate cutadaptenv

#######################################################################################################################
while IFS=" " read -r value1 value2

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=${RAW_DATA}/${value1}/${value2}_L1_1.fq.gz
SECCOND_SAMPLE_LOC=${RAW_DATA}/${value1}/${value2}_L1_2.fq.gz



####################################Adapter Removing####################################################################


cd $ADP_REM_BB

bbduk.sh -Xmx1g in1=$FIRST_SAMPLE_LOC in2=$SECCOND_SAMPLE_LOC out1=${value1}_bb_trim_R1.fastq out2=${value1}_bb_trim_R2.fastq  \
 ref=$ADADPTER_SEQ ktrim=r k=23 mink=11 hdist=1 tpe tbo qtrim=rl trimq=$QUALIY_THRESHOLD minlen=$MIN_LENGTH

####################################Fastqcaftertrimming#############################################################################

cd $A_Q_T

fastqc $ADP_REM_BB/${value1}_bb_trim_R1.fastq $ADP_REM_BB/${value1}_bb_trim_R2.fastq -o $PWD


} done <"$file"

#conda deactivate

