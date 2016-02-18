#!/bin/bash

for file in ./*.fastq

do

sample=`echo $file | cut -f2 -d "/" | cut -f1 -d "_"`

bowtie2 -p 16 -x genome -U $file -S ${sample}.sam 2> ${sample}_bowtie2.stderr

done

