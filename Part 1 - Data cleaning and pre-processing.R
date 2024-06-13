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

dim(data) # 20246 rows and 61 columns #one extra column for names of the genes

#View(data)

colnames(data)[1] = "Gene" #or rename using data <- rename(data, Gene = X)

#get metadata to distinguish between normal and cancerous samples

gse <- getGEO(GEO = 'GSE183947', GSEMatrix = TRUE)
Sys.setenv("VROOM_CONNECTION_SIZE" = 131072 * 1000) #to avoid error

show(gse) #provides information about the retrieved GEO dataset

#in our case there are 60 samples in the dataset and lacks feature-level expression data and protocol information
#class of the object, dimensions of the dataset, including the number of features (genes/probes) and samples.
#Metadata such as the title, description, and number of samples and their names.

metadata <- pData(phenoData(gse[[1]])) #to get phenotype data

#View(metadata)

subset_metadata = select(metadata,c(1,10,11,17)) #extracted title, tissue (normal/tumour),metastasis status, description (later renamed as Samples)

#or use subset_metadata = metadata[,c(1,10,11,17)] #to select particular columns

#View(subset_metadata) 

#renaming all the columns of the subset dataframe

colnames(subset_metadata)[c(1, 2, 3, 4)] <- c('Title','Tissue', 'Metastasis', 'Description') 

#editing input of a particular columns

subset_metadata$Tissue <- gsub("tissue: ", "", subset_metadata$Tissue) #remove "tissue: "

subset_metadata$Metastasis <- gsub("metastasis: ", "", subset_metadata$Metastasis) #remove "metastasis: "

long_df <- data %>%
  gather(key = 'Samples', value = 'FPKM', -Gene) 

#gather funtion turns columns into rows

#Samples contain all the columns and their values will be in FPKM 

#-Gene means DO NOT fuck with Gene column

#View(long_df)

new_df <- long_df %>%
  left_join(., subset_metadata, by = c("Samples" = "Description"))

#left join to keep all the rows of long_df and whereever key match, club together both df via common columns between two dataframe

View(new_df)

########### to understand no of rows in metastasis #################

a = filter(new_df, Metastasis == "no") #or you can try new_df[new_df$Metastasis == "no",]

#View(a) #all the rows and columns with metastasis status as no

nrow(a) #no of rows with metastasis status as "no"

b = filter(new_df, Metastasis == "yes")

#View(b) #all the rows with metastasis status as yes

nrow(b) #no of rows with metastasis status as "no"

total = nrow(a) + nrow(b)

nrow(new_df)

print(total)

nrow(new_df) == total #there are same no of metastasis and non metastasis case

########### to understand if there's any na or NAN  #################

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

#View(f) 


####################### Calculating mean FPKM for BRAC1 and BRCA2 in both normal and tumor tissues #####################


new_df %>%
  filter(Gene == "BRCA1" | Gene == "BRCA2") %>%
  group_by(Gene,Tissue) %>%
  summarise(mean_FPKM = mean(FPKM)) %>%
  arrange(desc(mean_FPKM))

#BRCA1 and BRCA2 are tumor suppressor genes, involved in DNA damage repair.
#Mutation in these gene leads to breast cancer.
#Mutations in BRCA1 and BRCA2 generally lead to a decrease or loss of their gene function rather than an increase in gene expression.
#According to the table, BRCA1 gene has the highest mean gene expression.
#Mean FPKM value of BRCA1 gene is more in normal breast tissue as compared to tumor breast tissue.
#followed by BRCA2 in normal breast tissue and finally BRCA2 breast tumor. 

dim(new_df)

file_path = "C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles/new_df.csv"

#saving this dataframe 
write.csv(new_df, file_path, row.names = FALSE)