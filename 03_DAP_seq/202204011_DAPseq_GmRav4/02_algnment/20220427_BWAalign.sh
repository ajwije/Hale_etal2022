#!/bin/bash


###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4/00_data/20220427_filenames.txt"


PROJECT_SAMPLE_DIR=/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4

RAW_DATA=00_data


QTRIM_DATA=${PROJECT_SAMPLE_DIR}/01_PREPROCESSING


ADP_REM=${QTRIM_DATA}/Adapter_Removed/header_changed

BWA_ALIGNED=${PROJECT_SAMPLE_DIR}/02_algnment


##################################Reference sequences##################################################################

ref_genome=/home/labcomputer/Documents/Asela/data/genome/Gmax_508_v4.0.softmasked


###################################SOFTWARE SETTINGS##################################################################


num_thread=12


#######################################################################################################################
while IFS= read -r line

do {


##################################fastq files#####################################################################

FIRST_SAMPLE_LOC=${ADP_REM}/${line}_trim_R1.fastq
SECCOND_SAMPLE_LOC=${ADP_REM}/${line}_trim_R2.fastq



####################################bwa alignment#############################################################################

cd $BWA_ALIGNED

echo ${line}

bwa mem -t $num_thread $ref_genome $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC |
samtools view \
-Shb -o ${line}.bam -


} done <"$file"

