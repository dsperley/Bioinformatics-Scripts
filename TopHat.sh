n 2_TopHat folder
## 
## setting up links for bowtie2 index
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.1.bt2 ./mm10.1.bt2
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.2.bt2 ./mm10.2.bt2
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.3.bt2 ./mm10.3.bt2
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.4.bt2 ./mm10.4.bt2
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.rev.1.bt2 ./mm10.rev.1.bt2
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome.rev.2.bt2 ./mm10.rev.2.bt2

## links for genome and gtf files
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa ./mm10.fa
ln -s /local_storage/annotation_db/Mus_musculus/UCSC/mm10/Annotation/Genes/genes.gtf ./mm10.gtf



for i  in `ls /local_storage/danielle.perley/ohm/Trimmed_FastQ/*atqt.fastq.gz | cut -f6 -d "/" | cut -f1,2 -d "_" | uniq` 
do

echo $i
## unzipping only read1 and read2 files
gunzip /local_storage/danielle.perley/ohm/Trimmed_FastQ/${i}_R*.gz

##linking files to current directory
ln -s /local_storage/danielle.perley/ohm/Trimmed_FastQ/${i}_R1_atqt.fastq .
ln -s /local_storage/danielle.perley/ohm/Trimmed_FastQ/${i}_R2_atqt.fastq .

read1=${i}_R1_atqt.fastq
read2=${i}_R2_atqt.fastq

sample=`echo $i| cut -f1 -d "_"`
lane=`echo $i | cut -f2 -d "_"`
mkdir  /local_storage/danielle.perley/ohm/2_TopHat/$i

date +"%m/%d/%Y %H:%M:%S"

# tophat2
# options: -p threads
# genome
# -r insert size
# -o output directory
# -G annotation file
# transcriptome-index directory
# fastq files
# rg-sample and rg-id: sam header options


tophat2 -p16 -o /local_storage/danielle.perley/ohm/2_TopHat/$i \
       --transcriptome-index=/local_storage/danielle.perley/ohm/Assembly -G mm10.gtf \
       --rg-sample $sample --rg-id $lane \
        mm10 $read1 $read2 \
        2> ./${i}_TopHat.stderr.txt

#rename accepted_hits.bam file to sample.bam
mv /local_storage/danielle.perley/ohm/2_TopHat/$i/accepted_hits.bam /local_storage/danielle.perley/ohm/2_TopHat/$i/${i}.bam

ln -s /local_storage/danielle.perley/ohm/2_TopHat/$i/${i}.bam .

gzip /local_storage/danielle.perley/ohm/Trimmed_FastQ/${i}*.fastq

date +"%m/%d/%Y %H:%M:%S"
echo finished $i

done
        
   
        

