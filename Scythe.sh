#!/bash/bin

for file in ./*.fastq
do
sample=`echo $file | cut -f2 -d/ | cut -f1 -d_`
echo Processing $sample

scythe -a ../Adapters/TruSeq_Indexes.fa -q sanger -o ../Trimmed_FastQ/${sample}.at.fastq $file 2> ../Trimmed_FastQ/${sample}.scythe.stderr.txt

done
