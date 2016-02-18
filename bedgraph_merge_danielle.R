#########################################################
## This script will normalize all bedgraph files in a 
## folder based on the number of mapped reads present in 
## those bedgraph files.  files are normalized down to 
## the lowest number of reads to minimilize the noise in 
## downstream analysis.
#########################################################
library(data.table)

#########################################################
## functions
## This function will merge bedgraph files by summing up 
## the hits by location.  Careful, can take very long
## and an enormous ammount of memory

frame.merge <- function(x, y){
        ddply(merge(x, y, all=TRUE), .(chr, start, end),
                summarise, count=sum(count))
}

## A function to write a table with a header.  Used to produce 
## browser ready bedgraphs

write.table_with_header <- function(x, file, header, ...){
    cat(header, '\n',  file = file)
    write.table(x, file, append = T, ...)
}
#########################################################


#file_list <- list.files(pattern = '*_b1.bedgraph')
file_list <- c("mcf7_dmso_1_pub_b1.bedgraph", "mcf7_dmso_2_pub_b1.bedgraph", "mcf7_hs_1_b1.bedgraph", 
		"mcf7_tsa_1_b1.bedgraph", "mcf7_tsa_2_b1.bedgraph")
frame_list <- lapply(file_list, read.delim, skip=1, header=FALSE, col.names =
			c('chr', 'start', 'end', 'count'))

## merge samples with 2 reps then normalize the three frames
dmso_merged <- frame.merge(frame_list[[1]], frame_list[[2]])
tsa_merged <- frame.merge(frame_list[[4]], frame_list[[5]])

frame_list2 <- list(dmso_merged, frame_list[[3]], tsa_merged)

## Sum the counts column of all frames and save a vector of those counts.
mapped_reads <- lapply(frame_list2, function(x) sum(x$count))

## Find the smallest and create a list of normalization factors
norm_factors <- lapply(mapped_reads, function(x) x/min(unlist(mapped_reads)))

## Divide the lists by their nf
norm_frame_list <- Map(function(x, i) {x[, 4]=x[, 4]/i; return(x)}, frame_list2, norm_factors)

## The merge frame will merge all files in a list.  The other lines will merge pairs
#merge_frame <- Reduce(frame.merge, norm_frame_list)
dmso_merged <- frame.merge(norm_frame_list[[1]], norm_frame_list[[2]])
hs_merged <- frame.merge(norm_frame_list[[3]], norm_frame_list[[4]])
tsa_merged <- frame.merge(norm_frame_list[[5]], norm_frame_list[[6]])

## Create header
dmso_header <- "track type=bedGraph name=dmso_merged_normd_150504 visibility=full color=179,27,27 altColor=179,27,27 priority=20"
hs_header <- "track type=bedGraph name=hs_merged_normd_150504 visibility=full color=179,27,27 altColor=179,27,27 priority=20"
tsa_header <- "track type=bedGraph name=tsa_merged_normd_150504 visibility=full color=179,27,27 altColor=179,27,27 priority=20"

## Write back to beadgraph file
write.table_with_header(dmso_merged, file='dmso_merged_normd_150504.bedgraph', header=dmso_header,
			 sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table_with_header(hs_merged, file='hs_merged_normd_150504.bedgraph', header=hs_header,
			 sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
write.table_with_header(tsa_merged, file='tsa_merged_normd_150504.bedgraph', header=tsa_header,
			 sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

