library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation
library(ggplot2) #to create different graphs
library(plotly) #to create interactive plot

#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

new_df = read.csv("new_df.csv")


################### box plot #############

#box plot1

new_df %>%
  filter(Gene == 'BRCA1') %>%
  ggplot(., aes(x = Tissue, y = FPKM, fill = Metastasis)) +
  geom_boxplot() +
  scale_fill_manual(values = c("lightblue", "pink")) +
  ggtitle("Expression of BRCA1 based on tissues and metastasis")

#Each box plot shows the distribution of FPKM values within a tissue type
#The color of the box plots (light blue or pink) indicates whether the samples are from metastatic or non-metastatic tissues. 
#Since box plot of normal breast tissue without metastasis is smallest of all, and smaller than meatstasis box of the same tissue, it indicates that the FPKM values for metastatic samples have a very narrow range 
#or lesser variability compared to metastatic samples within same tissue.
#BRCA1 expression is lower in normal breast tissue compared to tumor tissue with metastasis (no) and 
#highest in normal breast tissue with metastasis (yes).

#surprisingly BRAC1 expression is equivalent in breast cancer samples regardless of their metastasis expression

#box plot2 
new_df %>%
  filter(Gene == 'BRCA2') %>%
  ggplot(., aes(x = Tissue, y = FPKM, fill = Metastasis)) +
  geom_boxplot() +
  scale_fill_manual(values = c("lightblue", "pink")) +
  ggtitle("Expression of BRCA1 based on tissues and metastasis")

#normal breast tissue without metastasis have narrow FPKM range compared to metastatasis samples of the same tissue.
