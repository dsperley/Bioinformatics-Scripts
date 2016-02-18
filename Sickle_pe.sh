#!/bin/bash

for read1 in *R1*.at.fastq
do 

read2=${read1/R1/R2}
sample=`echo $read1 | cut -f1 -d_`
trimmed1=${sample}_R1.atqt.fastq
trimmed2=${sample}_R2.atqt.fastq
singles=${sample}_singles.atqt.fastq

sickle pe -f $read1 \
	-r $read2 \
	-o $trimmed1 \
	-p $trimmed2 \
	-s $singles \
	-q 33 -l 25 -t sanger \
        1> ./${sample}.sickle.stout.txt

done

	
		
