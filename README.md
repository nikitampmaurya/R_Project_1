# R_projects

# Objective:

The primary objective of this project is to analyze gene expression data of breast cancer and normal breast tissues to understand the differential expression. 

# Key Accomplishment: 

- Utilized R programming with packages such as dplyr, tidyverse, ggplot2, and GEOquery to preprocess, analyze, and visualize gene expression data.
- Created various plots (bar plots, density plots, box plots, and scatter plots) to illustrate the expression patterns of key genes (e.g. BRCA1, BRCA2, TP53) and their correlation with breast cancer progression and metastasis.
  
# About DATA 

Link: (NCBI GEO DATASETS - GSE183947) - https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE183947

Dataset Overview: 

Breast cancer is one of the most common cancers globally, affecting millions of women each year. The GSE183947 dataset is associated with breast cancer tissue and includes RNA sequencing data from 30 pairs of normal and cancerous tissues. The RNA sequencing reads were normalized as Fragments Per Kilobase of transcript per Million mapped reads (FPKM) data.

# What is RNA Sequencing (RNA-seq)? 

There are two methods to measure gene expression: DNA microarray and RNA sequencing. 

Process: mRNA is extracted from both samples (normal and tumour samples) fragmented into smaller pieces, and then transcribed into cDNA using the reverse transcription method. Short DNA sequences called adapters are added to the ends of the cDNA fragments. These adapters are necessary for binding the cDNA to the sequencing platform. cDNA fragments are then amplified using polymerase chain reaction (PCR) to create a library of cDNA fragments. cDNA library is loaded onto a sequencing platform (such as Illumina, PacBio, or Oxford Nanopore). The platform reads the sequences of the cDNA fragments. These reads are aligned to a reference genome (the number of reads that map to each gene or transcript is counted. This read count is proportional to the gene's expression level), and raw read counts are normalized to compensate for differences in sequencing depth and gene length. Common normalization methods include FPKM (Fragments Per Kilobase of transcript per Million mapped reads) and TPM (Transcripts Per Million). And ultimately, we perform Differential Gene Expression Data Analysis using R.

# What is FPKM?  

Fragments Per Kilobase of transcript per Million mapped reads (FPKM) is a simple common normalization method used in RNA-seq analysis. The FPKM normalizes read count based on gene length and the total number of mapped reads. 

Longer transcripts are more likely to be sequenced and counted multiple times, so FPKM adjusts for this bias by dividing the read count by the transcript length (in kilobases). FPKM uses the total number of mapped fragments, not reads, in the denominator. 











