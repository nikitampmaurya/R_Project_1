library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation, visualization, and analysis.
library(plotly)

#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

#####data visualization#####

new_df = read.csv("new_df.csv")

#View(new_df)

gene_of_interest = c("BRCA1","BRCA2", "TP53", "ALK", "MYCN")

filtered_df = new_df %>%
  filter(Gene %in% gene_of_interest) %>%
  spread(key = Gene, value = FPKM)

#View(filtered_df)

filtered_df1 <- as.matrix(filtered_df[, gene_of_interest])

# Add sample names as row names
rownames(filtered_df1) <- filtered_df$Samples

#View(filtered_df1)

plot_heatmap <- plot_ly(
  x = colnames(filtered_df1), 
  y = rownames(filtered_df1),  
  z = filtered_df1,  
  type = "heatmap",
  colorscale = list(c(0, 1), c("white", "red"))
) %>%
  layout(
    title = "Expression of Genes of Interest",
    xaxis = list(title = "Genes"),
    yaxis = list(title = "Samples")
  )

# Display the heatmap
plot_heatmap

#lighter color low expression, samples with darker color have higher expression for that gene
#Mycn has lowest expression in all the samples
#BRCA2 and ALK have almosr similar expression
#while TP53 is highly expressed in all the samples

