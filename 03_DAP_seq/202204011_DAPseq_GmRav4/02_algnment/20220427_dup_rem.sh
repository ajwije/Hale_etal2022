#!/bin/bash

###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4/00_data/20220427_filenames.txt"


PROJECT_SAMPLE_DIR=/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4

RAW_DATA=00_data


QTRIM_DATA=${PROJECT_SAMPLE_DIR}/01_PREPROCESSING


ADP_REM=${QTRIM_DATA}/Adapter_Removed

BWA_ALIGNED=${PROJECT_SAMPLE_DIR}/02_algnment

SORTED_FILE=${BWA_ALIGNED}/sorted_bam
mkdir $SORTED_FILE

UNIQ_READS=${BWA_ALIGNED}/uniq_reads
mkdir $UNIQ_READS

DUP_REM=${BWA_ALIGNED}/dup_rem
mkdir $DUP_REM




###################################SOFTWARE SETTINGS##################################################################


num_thread=12


#######################################################################################################################
while IFS= read -r line

do {

ALIGN_FILE=${BWA_ALIGNED}/${line}.bam


####################################bwa alignment#############################################################################


echo ${line}

sambamba sort -t $num_thread -o $SORTED_FILE/${line}_sorted.bam $ALIGN_FILE

sambamba markdup -r $SORTED_FILE/${line}_sorted.bam $DUP_REM/${line}_sorted_remdup.bam


sambamba view -h -t $num_thread -f bam -F "[XT] == null and not unmapped  and not duplicate and proper_pair" $DUP_REM/${line}_sorted_remdup.bam > $UNIQ_READS/${line}_sorted_uniq.bam

sambamba flagstat $DUP_REM/${line}_sorted_remdup.bam > $DUP_REM/${line}_sorted_remdup_flagstat.txt
sambamba flagstat $UNIQ_READS/${line}_sorted_uniq.bam > $UNIQ_READS/${line}_sorted_uniq_flagstat.txt

} done <"$file"

