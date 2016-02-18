#!/bin/bash

for file in ./*.sam
do 
sample=`echo $file | cut -f2 -d/ | cut -f1 -d.`
echo Processing $sample

htseq-count -q -s no $file genes.gtf > ${sample}_count.txt

done
