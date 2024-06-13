library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation
library(ggplot2) #to create different graphs
library(plotly) #to create interactive plot

#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

new_df = read.csv("")

########## density plot/ area plot ###########

#Plot 1
new_df %>%
  filter(Gene == "BRCA1") %>%
  ggplot(., aes(x = FPKM, fill = Tissue)) +
  geom_density(alpha = 0.3) +
  labs(title = "Density Plot of FPKM for BRCA1")

#Higher peaks indicate more samples having those FPKM values.
#According to graph,normal breast tissue sample have two peaks while breast tumor samples peak only between 0 to 10.
#The highest peak of normal breast tissue is also around same range, incdicating higher no of samples within that range.
#the 2nd highest peak of normal breast tissue is between 15 to 20.
#all the normal breast tissue samples have FPKM between 0 to 20.
#Breast tumor samples, on the other hand, have a wider distribution of FPKM values across the x-axis.

#here more accurate graph in plotly

#plot 2
filtered_df <- new_df %>%
  filter(Gene == "BRCA1")

plot_brca1_density = plot_ly(filtered_df, x = ~FPKM, color = ~Tissue, type = 'histogram', histnorm = 'density', opacity = 0.3) %>%
  layout(title = "Histogram of FPKM for BRCA1",
         xaxis = list(title = "FPKM"),
         yaxis = list(title = "Density"),
         barmode = "overlay",
         legend = list(title = list(text = "Tissue")))


plot_brca1_density #Display the plot

#narrating same story as above with exact values upon hovering.

#plot 3
new_df %>%
  filter(Gene == "BRCA1") %>%
  ggplot(., aes(x = FPKM, fill = Metastasis)) +
  geom_density(alpha = 0.3) +
  ggtitle("Density of Metastasis for BRCA1")

#brac1 expression in most samples with no metastasis peak around 4 to 8 FPKM.
#samples with metastasis exhibit a wider range of FPKM values, indicating potentially more variable BRCA1 expression.


plot_brca1_meta = plot_ly(filtered_df, x = ~FPKM, color = ~Metastasis, type = 'histogram', histnorm = 'density', opacity = 0.3) %>%
  layout(title = "Histogram of FPKM and metastasis density for BRCA1",
         xaxis = list(title = "FPKM"),
         yaxis = list(title = "Density"),
         barmode = "overlay",
         legend = list(title = list(text = "Metastasis")))

plot_brca1_meta

#narrating same story as above with exact values upon hovering.


##brca2 plots


#plot1

new_df %>%
  filter(Gene == "BRCA2") %>%
  ggplot(., aes(x = FPKM, fill = Tissue)) +
  geom_density(alpha = 0.3) +
  ggtitle("Density plot for BRCA2")


filtered_df2 <- new_df %>%
  filter(Gene == "BRCA2")


plot_brca2_density = plot_ly(filtered_df2, x = ~FPKM, color = ~Tissue, type = 'histogram', histnorm = 'density', opacity = 0.3) %>%
  layout(title = "Histogram Plot of FPKM for BRCA2",
         xaxis = list(title = "FPKM"),
         yaxis = list(title = "Density"),
         barmode = "overlay",
         legend = list(title = list(text = "Tissue")))


plot_brca2_density

#higher expression and density of breast tumor samples around 0 to 2 FPKM.
#while normal breast tissue peak around 0 to 5 range.


