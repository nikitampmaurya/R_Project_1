library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation
library(plotly) #to create interactive plot

#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

new_df = read.csv("new_df.csv")


################### box plot #############

#box plot1

filtered_df = new_df %>%
  filter(Gene == "BRCA1") 

#View(filtered_df) #30 samples of normal (half of them are positive for metastasis) and 30 samples of tumor samples (half of them are positive for metastasis).

plot_df = plot_ly(
  data= filtered_df,
  x = ~Tissue,
  y = ~FPKM,
  type = "box",
  color = ~Metastasis,
  colors = c("lightblue", "pink"),
  boxpoints = 'all', #to show all points
  jitter = 0.5 #to prevent overlapping, higher values spread the points more horizontall
) %>%
  layout(
    title = "Expression of BRCA1 based on tissues and metastasis",
    xaxis = list(title = "Tissue"),
    yaxis = list(title = "FPKM"),
    boxmode = "group" # group boxes by Tissue and Metastasis
  )

plot_df #to view the plot

#Each box plot shows the distribution of FPKM values within a tissue type
#The color of the box plots (light blue or pink) indicates whether the samples are from metastatic or non-metastatic tissues. 
#Since box plot of normal breast tissue without metastasis is smallest of all,it indicates that the FPKM values for non-metastatic samples have a very low FPKM (less than 10) and narrow range of FPKM (3 to 10). 
#There are almost equivalent no of samples with similar amount of FPKM in breast tumor samples. 
#indicating that BRAC1 expression is equivalent in breast cancer samples regardless of their metastasis expression
#BRCA1 expression is lower in normal breast tissue compared to tumor tissue with metastasis (no) and 
#highest in normal breast tissue with metastasis (yes).
 
#box plot2 

filtered_df1 = new_df %>%
  filter(Gene == "BRCA2") 

View(filtered_df2) #30 samples of normal (half of them are positive for metastasis) and 30 samples of tumor samples (half of them are positive for metastasis).

plot_df1 = plot_ly(
  data= filtered_df1,
  x = ~Tissue,
  y = ~FPKM,
  type = "box",
  color = ~Metastasis,
  colors = c("lightblue", "pink"),
  boxpoints = 'all', #to show all points
  jitter = 0.5 #to prevent overlapping, higher values spread the points more horizontall
) %>%
  layout(
    title = "Expression of BRCA2 based on tissues and metastasis",
    xaxis = list(title = "Tissue"),
    yaxis = list(title = "FPKM"),
    boxmode = "group" # group boxes by Tissue and Metastasis
  )

plot_df1 #to view the plot

#Overall expression of BRCA2 gene is more expressed in breast tissues that exhibit metastasis.
#breast tumor samples have equivalent amount of BRCA2 expression in breast tumor.

