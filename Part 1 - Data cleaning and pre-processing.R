library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation, visualization, and analysis.
library(ggplot2) #to create different graphs
library(plotly) #to interactive graphs
library(GEOquery) #for accessing and retrieving data from the Gene Expression Omnibus (GEO) database.

#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

#after manual downloading the data from ncbi GEO database
#I have loaded the data
#contains 30 pairs of normal and cancerous breast tissues 

data = read.csv("GSE183947_fpkm.csv")

dim(data) # 20246 rows and 61 columns #one extra column for name of the genes

#View(data) #name of the genes (observations) and 60 samples (variables)

colnames(data)[1] = "Gene" #or rename using data <- rename(data, Gene = X)

#get metadata to distinguish between normal and cancerous samples

gse <- getGEO(GEO = 'GSE183947', GSEMatrix = TRUE)
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 1000) #to avoid error

show(gse) #provides information about the retrieved GEO dataset

#in our case there are 60 samples in the dataset
#phenoData section shows that there are 60 sample names, ranging from GSM5574685 to GSM5574744. 
#also includes 41 variable labels (e.g., title, geo_accession, tissue:ch1) that describe various attributes of the samples. 

metadata <- pData(phenoData(gse[[1]])) #to get phenotype data

#View(metadata) #contains name of the tissues, metastasis status, name of tissue samples, submission date, geoacession etc

subset_metadata = select(metadata,c(1,10,11,17)) #extracted title, tissue (normal/tumour), metastasis status, description (later renamed as Samples)

#or use subset_metadata = metadata[,c(1,10,11,17)] #to select particular columns

#View(subset_metadata) 

#renaming all the columns of the subset dataframe

colnames(subset_metadata)[c(1, 2, 3, 4)] <- c('Title','Tissue', 'Metastasis', 'Description') 

#editing input of a particular columns

subset_metadata$Tissue <- gsub("tissue: ", "", subset_metadata$Tissue) #remove "tissue: "

subset_metadata$Metastasis <- gsub("metastasis: ", "", subset_metadata$Metastasis) #remove "metastasis: "

long_df <- data %>%
  gather(key = 'Samples', value = 'FPKM', -Gene) 

#gather function turns columns into rows

#Samples contain all the columns and their values will be in FPKM 

#-Gene means DO NOT include Gene column

#View(long_df)

new_df <- long_df %>%
  left_join(., subset_metadata, by = c("Samples" = "Description"))

#left join to keep all the rows of long_df and wherever key match, club together both dfs via common columns

View(new_df)

########### to understand the no of rows in metastasis #################

a = filter(new_df, Metastasis == "no") #or you can try new_df[new_df$Metastasis == "no",]

#View(a) #all the rows and columns with metastasis status as no

nrow(a) #no of rows with metastasis status as "no"

b = filter(new_df, Metastasis == "yes")

#View(b) #all the rows with metastasis status as yes

nrow(b) #no of rows with metastasis status as "no"

total = nrow(a) + nrow(b)

nrow(new_df)

print(total)

nrow(new_df) == total #there are same no of metastasis and non-metastasis samples for each tissue.

########### to understand if there's any NA or NAN  #################

has_na <- any(is.na(new_df))
print(has_na) #there is no na data

##################### unique values in my dataset ####################

new_df %>% distinct(Tissue) #types of tissues: only two #or use unique(new_df$Tissue)

new_df %>% distinct(Metastasis) #only two metastasis status "yes" and "no" #or use unique(new_df$Metastasis)

new_df %>% distinct(Title) #60 different types of tissues or unique(new_df$Title)

new_df %>% distinct(Samples) #60 unique samples #or unique(new_df$Samples)

nrow(new_df %>% distinct(Gene)) #total 20,246 unique genes

c = new_df[new_df$Gene == "BRCA1",] #to find all the entries with particular gene BRAC1

#View(c) #60 rows of BRCA1 gene with metastatsis status yes and no

d = new_df[new_df$Gene == "BRCA2",] #to find all the entries with particular gene BRAC2

#View(d) #60 rows of BRCA2 gene with metastatsis status yes and no

e = new_df[new_df$Gene == "BRCA1" & new_df$Metastasis == "yes",] 

#View(e) #30 rows of BRCA1 gene with metastasis status yes

f = new_df[new_df$Gene == "BRCA1" & new_df$Metastasis == "no",] 

#View(f) #30 rows of BRCA1 gene with metastasis status no

dim(new_df)

file_path = "C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles/new_df.csv"

#saving this data frame 
write.csv(new_df, file_path, row.names = FALSE)
