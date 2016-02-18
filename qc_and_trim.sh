#!/bin/bash


i=fastq

## First loop will analyze all fastq files in the folder and produce 
## _fastqc.html and _fastqc.zip

for file in ./*.fastq

do

echo $file

date +"%m/%d/%Y %H:%M:%S"

fastqc -f fastq -t 16 $file 

done

## This second loop will run a quality trim on all the fastq files and
## and return them as *_trimmed.fastq

for file in ./*.fastq

do

#echo $file

sample=`echo $file | cut -f2 -d "/" | cut -f1 -d "_"`

echo $sample
date +"%m/%d/%Y %H:%M:%S"

sickle se -f $file -t sanger -o ${sample}_trimmed.fastq -q 33 -l 40

echo ${sample}_trimmed.fastq finished!

done

## Finally run fastqc on the trimmed files
for file in ./*trimmed.fastq

do

echo $file

date +"%m/%d/%Y %H:%M:%S"

fastqc -f fastq -t 16 $file 

done
