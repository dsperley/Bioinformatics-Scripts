#!/bin/bash
#
#for file in *.sam
#do 
#
#sample=`echo $file | cut -f1 -d.`
#echo sorting $sample
#
#samtools view -bS $file | samtools sort - ${sample}_sorted
#
#done
#
#
#for file in *_sorted.bam
#do
#
#sample=`echo $file | cut -f1 -d_`
#echo indexing $sample
#
#samtools index $file
#
#done


for file in *.sam
do

sample=`echo $file | cut -f1 -d.`

echo sorting $sample

samtools view -bS $file | samtools sort -n -  ${sample}_sorted_name 

done
