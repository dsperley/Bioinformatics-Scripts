#!/bin/bash

for file  in ./*.atqt.fastq
do

sample=`echo $file | cut -f2 -d/ | cut -f1 -d_`

fastqc $file -o ../1_FastQC/$sample 
done
