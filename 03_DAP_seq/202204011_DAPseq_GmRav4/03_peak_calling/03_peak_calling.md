# Title: peak calling using MACS

## Date: 06/24/2020

## Computername and path of working directory

- Laptops: ```/Documents/Projects/Soy_RNAseq/DAPseq/200617_data_analysis/03_peak_calling/```

- Lab computers: 
				genomes: ```~/Documents/Asela/data/genome```

				```~/Documents/Asela/data/20_DAPseq_data/03_peak_calling```




## Description of what you are trying to do and why

Using MACS to peak calling using ```macs2 2.2.7.1```. 

## Code block of the commands you used
- calculate the effective genome size for soybean genome with khmer size of 150. 
	```unique-kmers.py -k 150 Gmax_508_v4.0.softmasked.fa.gz``` == 906247355
	
- size of the soybean genome: 
	```./faSize Gmax_508_v4.0.softmasked.fa.gz > Gmax_508_v4.0.softmasked.totalbasecounts.txt```
	
	 - 978386919 bases (25907548 N's 952479371 real 526103229 upper 426376142 lower) in 282 sequences in 1 files

	
for i in *_summits.bed; do wc -l $i; echo $i; done > uniq_peak_number.txt 


- script: 2020624_macs.sh

## Description of the result


