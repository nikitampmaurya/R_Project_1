# R_projects

## - There are two methods to measure gene expression: DNA microarray and RNA sequencing

## - DNA Mirco array - mRNA is extracted from both samples (normal and tumour samples), then transcribed into cDNA using the reverse transcription method. During this process, cDNA from both samples are labelled with different fluorescent molecules. The microarray plate has many spots/holes, each embedded with multiple short probes (oligonucleotide of target Gene X). cDNA from both samples are allowed to hybridize to their complementary probes on the microarray, then after the washing step and the amount of fluorescence received from each spot indicates the expression level of the corresponding gene from both the samples. By interpreting the result, we learn if the gene is expressed in the samples and its intensity. 

## RNA Sequencing - mRNA is extracted from both samples (normal and tumour samples) fragmented into smaller pieces, and then transcribed into cDNA using the reverse transcription method. Short DNA sequences called adapters are added to the ends of the cDNA fragments. These adapters are necessary for binding the cDNA to the sequencing platform. cDNA fragments are then amplified using polymerase chain reaction (PCR) to create a library of cDNA fragments. cDNA library is loaded onto a sequencing platform (such as Illumina, PacBio, or Oxford Nanopore). The platform reads the sequences of the cDNA fragments. These reads are aligned to a reference genome (the number of reads that map to each gene or transcript is counted. This read count is proportional to the gene's expression level), and raw read counts are normalized to compensate for differences in sequencing depth and gene length. Common normalization methods include FPKM (Fragments Per Kilobase of transcript per Million mapped reads) and TPM (Transcripts Per Million). And at the end, we perform Differential Gene Expression Data Analysis using R.

##What is FPKM?  

#Fragments Per Kilobase of transcript per Million mapped reads (FPKM) is a simple common normalization method used in RNA-seq analysis. The FPKM normalizes read count based on gene length and the total number of mapped reads. 

#Longer transcripts are more likely to be sequenced and counted multiple times, so FPKM adjusts for this bias by dividing the read count by the transcript length (in kilobases). FPKM uses the total number of mapped fragments, not reads, in the denominator. 








