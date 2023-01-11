# Title: Alignment with bwa

## Date: 04/27/2022

## Computername and path of working directory

- Laptops: ```/Documents/Projects/Methylation/200520_W82-Rpsk1/06_bwameth_align```

- Lab computers: 
				genomes: ```~/Documents/Asela/data/genome```

				```~/Documents/Asela/data/20_DAPseq_data/00_row_data/02_algnment```




## Description of what you are trying to do and why

- Align reads to soybean genome.   

## Code block of the commands you used

- genome was downloaded from Phytozome. Annotation-version = Wm82.a4.v1. 

- Gmax_508_v4.0.softmasked.fa.gz

- Nucleotide FASTA format of the current genomic assembly, masked for repetitive sequence by RepeatMasker 
   (softmasked sequence is in lower case).

- Indexing the genome:
```bwa index -p Gmax_508_v4.0.softmasked -a bwtsw Gmax_508_v4.0.softmasked.fa.gz
# -p index name (change this to whatever you want)
# -a index algorithm (bwtsw for long genomes and is for short genomes)```

- 

- script: 20220427_BWAalign.sh

##remove duplicates and count number of aligned reads using following scripts: 

20220428_dup_rem.sh

There was core dump error. 
had to use the following command:

sambamba markdup -r  --hash-table-size=4194304 SRR13197374_sorted.bam ../dup_rem/SRR13197374_sorted_remdup.bam

## Description of the result

