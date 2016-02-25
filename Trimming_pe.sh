s script unzips only the Read 1 and Read 2 fastq files for a sample, then performs adaptor and quality trimming using scythe and sickle, and finally 
## zips up the quality trimmed fastq files 

for i in `ls /local_storage/danielle.perley/ohm/fastq_raw_data/*.fastq.gz |cut -f6 -d "/" | cut -f1-3 -d "_" | uniq` 

do

echo Scythe processing $i

# unzips only the fastq files needed
gunzip /local_storage/danielle.perley/ohm/fastq_raw_data/${i}*.gz


fastq1=/local_storage/danielle.perley/ohm/fastq_raw_data/${i}_R1_001.fastq
fastq2=/local_storage/danielle.perley/ohm/fastq_raw_data/${i}_R2_001.fastq


prefix=`echo $i | cut -f1,3 -d "_"`
sample=`echo $i | cut -f1 -d "_"`

#R1
#For R1 reads, each sample will have a different adaptor. Instead of Scythe looking through each file 20 times, 
#put the adapter for each sample in a different file
echo Trimming ${i}_R1 adapters
scythe -a ./Adapters/${sample}_R1.fa -q sanger -n 3 -o /local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_R1_at.fastq $fastq1 \
2> ./1_Trimming/${prefix}_R1_scythe.stderr.txt


echo Trimming ${i}_R2 adapters
#R2
scythe -a ./Adapters/R2_adapters.fa -q sanger -n 3 -o /local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_R2_at.fastq $fastq2 \
2> ./1_Trimming/${prefix}_R2_scythe.stderr.txt
 
#sickle

read1=/local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_R1_at.fastq
read2=/local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_R2_at.fastq

trimmed1=/local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_R1_atqt.fastq
trimmed2=/local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_R2_atqt.fastq
singles=/local_storage/danielle.perley/ohm/Trimmed_FastQ/${prefix}_singles_atqt.fastq

echo Sickle processing $sample

sickle pe -f $read1 \
	-r $read2 \
	-o $trimmed1 \
	-p $trimmed2 \
	-s $singles \
	-q 33 -l 45 -t sanger \
        1> ./1_Trimming/${prefix}.sickle.stout.txt

#remove adaptor trimmed fastq
rm /local_storage/danielle.perley/ohm/Trimmed_FastQ/*_at.fastq

echo zipping files..
gzip /local_storage/danielle.perley/ohm/Trimmed_FastQ/*.fastq /local_storage/danielle.perley/ohm/fastq_raw_data/*.fastq

done


