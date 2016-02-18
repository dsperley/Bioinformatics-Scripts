#!/bin/bash


for file  in ./*.fastq
do

sample=`echo $file | cut -f2 -d/ | cut -f1,4 -d_`
mkdir ../1_FastQC/$sample

fastqc $file -o ../1_FastQC/$sample 
done
