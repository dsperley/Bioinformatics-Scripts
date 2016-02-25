s script unzips only fastq files for one sample, then performs adaptor and quality trimming using scythe and sickle, and finally 
## zips up the quality trimmed fastq files 

for i in `ls /local_storage/danielle.perley/Min_Wu/15-025/raw_fastq/*.fastq.gz |cut -f7 -d "/" | cut -f1-6 -d "_" | uniq` 

do

echo Scythe processing $i

# unzips only the fastq files needed
gunzip /local_storage/danielle.perley/Min_Wu/15-025/raw_fastq/${i}*.gz


fastq1=/local_storage/danielle.perley/Min_Wu/15-025/raw_fastq/${i}_001.fastq


prefix=`echo $i | cut -f1-3,5 -d "_"`
sample=`echo $i | cut -f1-3 -d "_"`



echo Trimming ${i}  adapters
#R1
scythe -a ./Overrep_Adaptors.fa -q sanger -n 3 -o /local_storage/danielle.perley/Min_Wu/15-025/Trimmed/${prefix}_at.fastq $fastq1 \
2> ./Trimming/${prefix}_scythe.stderr.txt
 
#sickle

read1=/local_storage/danielle.perley/Min_Wu/15-025/Trimmed/${prefix}_at.fastq

trimmed1=/local_storage/danielle.perley/Min_Wu/15-025/Trimmed/${prefix}_atqt.fastq

echo Sickle processing $sample

sickle se -f $read1 \
	-o $trimmed1 \
	-q 30 -l 45 -t sanger \
        1> ./Trimming/${prefix}.sickle.stout.txt

#remove adaptor trimmed fastq
rm /local_storage/danielle.perley/Min_Wu/15-025/Trimmed/*_at.fastq

echo zipping files..
gzip /local_storage/danielle.perley/Min_Wu/15-025/Trimmed/*.fastq /local_storage/danielle.perley/Min_Wu/15-025/raw_fastq/*.fastq

done

###does FastQC on trimmed fastq files

for file in /local_storage/danielle.perley/Min_Wu/15-025/Trimmed/*.fastq.gz
do

fastqc $file -o ./FastQC

done

