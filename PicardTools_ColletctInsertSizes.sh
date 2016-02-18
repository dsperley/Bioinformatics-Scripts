#!/bin/bash

for file in *_sorted.bam
do

sample=`echo $file | cut -f1 -d_`

java -jar ~/picard-tools-1.133/picard.jar CollectInsertSizeMetrics \
INPUT=$file \
OUTPUT=../../4_InsertSizes/${sample}_InsertSizes.txt \
HISTOGRAM_FILE=../../4_InsertSizes/${sample}_InsertSizes.pdf

done
