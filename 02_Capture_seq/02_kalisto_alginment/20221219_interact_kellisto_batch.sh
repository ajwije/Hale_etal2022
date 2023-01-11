#!/bin/bash


#Project directory

PROJECT_DIR=/home/awijeratne/Projects/capture_seq

#path to fastq files



FASTQ_FILE=$PROJECT_DIR/01_Preproprocessing/01_Preproprocessing/BB_Adapter_Removed


#this will creat a path to a folder called "abudnace_est"
COUNT=$PROJECT_DIR/02_kalisto_alginment


#assign the output to the COUNT folder 

OUTPUT=$COUNT

#indexing your reference 

INDEX=$PROJECT_DIR/Transcript_ref_V3/Gmax_508_Wm82.a4.v1.transcript_primaryTranscriptOnly.idx



#creating an array for names

array=(
TC_1_1
TC_1_2
TC_1_3
TC_1_4
TC_1_5
TC_1_6
TC_1_7
TC_1_8
TC_1_9
)

for s_names in "${array[@]}"


do {



FIRST_SAMPLE=$FASTQ_FILE/${s_names}_bb_trim_R1.fastq

SECCOND_SAMPLE=$FASTQ_FILE/${s_names}_bb_trim_R2.fastq



kallisto quant -i $INDEX -o $OUTPUT/${s_names} $FIRST_SAMPLE $SECCOND_SAMPLE



} done

