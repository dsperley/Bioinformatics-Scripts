#!/bin/bash

for file in ./*.at.fastq
do
sample=`echo $file | cut -f2 -d/ | cut -f1 -d.`
echo Processing $sample

sickle se -f $file -t sanger —q 33 -o ../Trimmed_FastQ/${sample}.atqt.fastq 1> ../Trimmed_FastQ/${sample}.sickle.stderr.txt

done