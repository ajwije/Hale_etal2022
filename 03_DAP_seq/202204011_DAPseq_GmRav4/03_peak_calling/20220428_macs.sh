#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################

PROJECT_SAMPLE_DIR=/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4

RAW_DATA=00_data


QTRIM_DATA=${PROJECT_SAMPLE_DIR}/01_PREPROCESSING


ADP_REM=${QTRIM_DATA}/Adapter_Removed/header_changed

BWA_ALIGNED=${PROJECT_SAMPLE_DIR}/02_algnment



PEAK_CALL=${PROJECT_SAMPLE_DIR}/03_peak_calling

file="/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4/00_data/20220427_filenames_2.txt"

##################################background with empty vector peaks##################################################################

NEG_CONT1=${BWA_ALIGNED}/dup_rem/SRR13197374_sorted_remdup.bam

###################################SOFTWARE SETTINGS##################################################################


num_thread=12


#######################################################################################################################
while IFS= read -r line

do {


##################################fastq files#####################################################################

ALIGN_FILE=${BWA_ALIGNED}/dup_rem/${line}_sorted_remdup.bam 




####################################peak calling #############################################################################


echo ${line}

macs2 callpeak -t ${ALIGN_FILE} \
	-c ${NEG_CONT1} \
 	-f BAM -g 906247355 \
	-n ${line} \
	--outdir ${PEAK_CALL} 2> ${line}.log

} done <"$file"

