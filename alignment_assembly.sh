###############################################################################
##### This script will run alignment and transcript assembly on all fastq #####
##### files within the folder it is run.  Before using please check the   #####
##### contents of the folder and the options called carefully!!!!!!       #####
###############################################################################


##  Tophat Command ##

#for file in ./*.fastq

#do

#date +"%m/%d/%Y %H:%M:%S"

#sample=`echo $file | cut -f2 -d "/" | cut -f1 -d "_"`

#echo $sample
## command order
## call -threads -output --index location
## -annotation file -min length
## index base output name
#tophat2 -p16 -o $sample --transcriptome-index=transcriptome_data/ \
#-G ./genes.gtf \
#genome \
#$file > ./${sample}_tophat.stdout 2> ./${sample}_tophat.stderr

## rename accepted hits file to sample name
#mv -v ./$sample/accepted_hits.bam ./$sample/${sample}.bam

## link to alignment file for assembly loop simplicity
#ln -s ./$sample/${sample}.bam .

#date +"%m/%d/%Y %H:%M:%S"

#done

##  Cufflinks Command ##

for file in ./*.bam

do

date +"%m/%d/%Y %H:%M:%S"

sample=`echo $file | cut -f2 -d "/" | cut -f1 -d "."`

echo $sample

## command order
## call -threads -multi-read-correct-output file
## -bias correction fasta file - gtf-guide file
## sample name > output recording 

cufflinks -p16 -u -o $sample \
-b ./genome.fa -g ./genes.gtf \
$file > ./$sample/${sample}_cufflinks.stdout 2> ./$sample/${sample}_cufflinks.stderr

## rename transcripts file to sample name
mv -v ./$sample/transcripts.gtf ./$sample/${sample}.gtf

date +"%m/%d/%Y %H:%M:%S"

done
