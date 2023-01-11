#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4/00_data/20220427_filenames.txt"


PROJECT_SAMPLE_DIR=/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4

RAW_DATA=00_data

QTRIM_DATA=${PROJECT_SAMPLE_DIR}/01_preprocessing

mkdir $QTRIM_DATA/FASTQC
mkdir $QTRIM_DATA/FASTQC/Before_Q_Trim

ADP_REM=$QTRIM_DATA/Adapter_Removed
mkdir $ADP_REM

A_Q_T=$QTRIM_DATA/FASTQC/FASTQ_After_Q_Trim
mkdir $A_Q_T

###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####
FASTQ_TYPE="sanger"
QUALIY_THRESHOLD=20
MIN_LENGTH=40
ADAPTER_SEQ=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC

U_ADAPTER_SEQ=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT


#######################################################################################################################
while IFS= read -r line

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=${PROJECT_SAMPLE_DIR}/${RAW_DATA}/${line}_pass_1.fastq.gz
SECCOND_SAMPLE_LOC=${PROJECT_SAMPLE_DIR}/${RAW_DATA}/${line}_pass_2.fastq.gz

####################################Fastqc#############################################################################

cd $QTRIM_DATA/FASTQC/Before_Q_Trim/

fastqc $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC -o $PWD

####################################Adapter Removing####################################################################

cd $ADP_REM

cutadapt -q $QUALIY_THRESHOLD --cores=12 -m $MIN_LENGTH -a $ADAPTER_SEQ -A $ADAPTER_SEQ -o ${line}_trim_R1.fastq -p ${line}_trim_R2.fastq $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC


####################################Fastqcaftertrimming#############################################################################

cd $A_Q_T

fastqc $ADP_REM/${line}_trim_R1.fastq $ADP_REM/${line}_trim_R2.fastq -o $PWD


} done <"$file"

