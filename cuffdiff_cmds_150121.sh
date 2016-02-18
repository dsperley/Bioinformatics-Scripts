
#date +"%m/%d/%Y %H:%M:%S"

#cuffdiff -p 16 -o cuffdiff_kovc_150121 -L WTC,KOC \
#-b genome.fa -u ./merged_assemblies_all_150121/merged_with_ref_ids.gtf \
#./IF1.bam,./IF2.bam \
#./IF9.bam \
#> ./cuffdiff_kovc_150121.stdout 2> ./cuffdiff_kovc_150121.stderr

#date +"%m/%d/%Y %H:%M:%S"

date +"%m/%d/%Y %H:%M:%S"

cuffdiff -p 16 -o cuffdiff_wt_time_150121 -L WTt0,WTt12,WTt36 \
-b genome.fa -u ./merged_assemblies_all_150121/merged_with_ref_ids.gtf \
./IF1.bam,./IF2.bam \
./IF3.bam,./IF4.bam \
./IF5.bam,./IF6.bam \
> ./cuffdiff_wt_time_150121.stdout 2> ./cuffdiff_wt_time_150121.stderr

date +"%m/%d/%Y %H:%M:%S"

date +"%m/%d/%Y %H:%M:%S"

cuffdiff -p 16 -o cuffdiff_ko_time_150121 -L KOt0,KOt12,KOt36 \
-b genome.fa -u ./merged_assemblies_all_150121/merged_with_ref_ids.gtf \
./IF9.bam \
./IF10.bam \
./IF11.bam,./IF12.bam \
> ./cuffdiff_ko_time_150121.stdout 2> ./cuffdiff_ko_time_150121.stderr

date +"%m/%d/%Y %H:%M:%S"

date +"%m/%d/%Y %H:%M:%S"

cuffdiff -p 16 -o cuffdiff_lasr_150121 -L WTt12,Las_t12 \
-b genome.fa -u ./merged_assemblies_all_150121/merged_with_ref_ids.gtf \
./IF3.bam,./IF4.bam \
./IF7.bam,./IF8.bam \
> ./cuffdiff_lasr_150121.stdout 2> ./cuffdiff_lasr_150121.stderr

date +"%m/%d/%Y %H:%M:%S"
