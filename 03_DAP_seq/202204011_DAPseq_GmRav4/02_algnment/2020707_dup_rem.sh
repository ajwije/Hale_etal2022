#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################



PPROJECT_SAMPLE_DIR=/home/labcomputer/Documents/Asela/data/20_DAPseq_data

QTRIM_DATA=${PROJECT_SAMPLE_DIR}/01_PREPROCESSING


ADP_REM=/home/labcomputer/Documents/Asela/data/20_DAPseq_data/01_PREPROCESSING/Adapter_Removed

BWA_ALIGNED=/home/labcomputer/Documents/Asela/data/20_DAPseq_data/02_algnment

SORTED_FILE=${BWA_ALIGNED}/sorted_bam

UNIQ_READS=${BWA_ALIGNED}/uniq_reads

file="/home/labcomputer/Documents/Asela/data/20_DAPseq_data/00_row_data/20200623_filenames.txt"


###################################SOFTWARE SETTINGS##################################################################


num_thread=12


#######################################################################################################################
while IFS= read -r line

do {


##################################fastq files#####################################################################

ALIGN_FILE=/home/labcomputer/Documents/Asela/data/20_DAPseq_data/02_algnment/${line}.bam




####################################bwa alignment#############################################################################


echo ${line}

sambamba sort -t $num_thread -o $SORTED_FILE/${line}_sorted.bam $ALIGN_FILE

sambamba view -h -t $num_thread -f bam -F "[XT] == null and not unmapped  and not duplicate and proper_pair" \
$SORTED_FILE/${line}_sorted.bam > $UNIQ_READS/${line}_sorted_uniq.bam

sambamba flagstat $UNIQ_READS/${line}_sorted_uniq.bam >> $UNIQ_READS/20200707_flagstat.txt

} done <"$file"

