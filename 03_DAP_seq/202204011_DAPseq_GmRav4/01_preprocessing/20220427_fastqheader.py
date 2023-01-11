'''
This script take fastq from SRA and add 1 and 2 to first and second reads. 
'''



import os
import HTSeq
sra_numbers = [
    "SRR13197374_trim_R1.fastq" ,"SRR13197373_trim_R1.fastq", "SRR13197372_trim_R1.fastq",
    "SRR13197374_trim_R2.fastq" ,"SRR13197373_trim_R2.fastq", "SRR13197372_trim_R2.fastq",
    ]


# directory where your files are located
file_dir = "/media/labcomputer/AWLABEX2/Asela/202204011_DAPseq_GmRav4/01_PREPROCESSING/Adapter_Removed"

header_changed = "header_changed"

for fq in sra_numbers:
	
	for s in HTSeq.FastqReader(file_dir + "/" + fq):
		header = s.name
		
		header = header.split(".")[0]
		print(header)
		if "R1" in fq:  
			mod_header = header + "_" + str(1)
			s.name = mod_header
			with open(file_dir + "/" + header_changed + "/" + fq, "a") as outFastq:

				s.write_to_fastq_file(outFastq)
		else: 
			mod_header = header + "_" + str(2)
			s.name = mod_header
			with open(file_dir + "/" + header_changed + "/" + fq, "a") as outFastq:

				s.write_to_fastq_file(outFastq)
		
	


#name_file.close()q