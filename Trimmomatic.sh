#!/bin/bash

for file in ./*.fastq
do
sample=`echo $file | cut -f2 -d/ | cut -f1 -d.`
echo $file

java -jar /Users/danielleperley/Documents/Bioinformatics_Core/Programs/Trimmomatic-0.32/trimmomatic-0.32.jar  SE -phred33 \
$file \
../1_150513/Trimmed_FastQ/${sample}.atqt.fastq \
ILLUMINACLIP:/Users/danielleperley/Documents/Bioinformatics_Core/Programs/Trimmomatic-0.32/adapters/TruSeq3-SE.fa:2:30:10 LEADING:10 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:36 \
2> ../1_150513/Trimmed_FastQ/${sample}_trimmomatic_stderr.txt

done
