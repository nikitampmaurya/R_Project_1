#key findings: 
#1. The expression levels of BRCA2 are consistently higher across nearly all samples compared to BRCA1.
#2. Tissue samples (both normal and breast cancer) positive for metastasis exhibit significantly elevated FPKM values.


library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation, visualization, and analysis.
library(plotly) #to create interactive plots

#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

#####data visualization#####

new_df = read.csv("new_df.csv")

dim(new_df) 

filtered_brca <- new_df %>%
  filter(Gene == "BRCA1" | Gene == "BRCA2")

#View(filtered_brca) #total 30 pairs of normal and tumor samples of BRCA1 (meaning total 60) and similarly for BRCA2

#barplot 1: # Plot for BRCA1 and BRCA2 expression across all samples

plotly_brca <- plot_ly(
  data = filtered_brca,
  x = ~Samples,
  y = ~FPKM,
  type = 'bar',
  color = ~Gene,
  colors = c("gray", "orange"),
  text = ~paste("Gene:",Gene,"<br>Tissue:", Tissue, "<br>Metastasis:", Metastasis, "<br>FPKM:", FPKM),
  hoverinfo = 'text',
  textposition = 'inside',
  insidetextanchor = 'middle'
) %>%
  layout(
    title = list(
      text = "Differential expression of BRCA1 and BRCA2 across all samples",
      font = list(size = 16, color = 'black', family = 'Arial', bold = TRUE),
      xanchor = "center",
      yanchor = "top"
    ),
    xaxis = list(title = "Samples"),
    yaxis = list(title = "FPKM"),
    barmode = 'stack'
  )

# Display the plot
plotly_brca

#clearly shows higher expression of BRCA2 compared to BRCA1 across all samples.

#barplot 2: Plot for BRCA1 expression based on metastasis across all samples


filtered_brca1 <- new_df %>%
  filter(Gene == "BRCA1")

#View(filtered_brca1) #total 60

plotly_brca1 <- plot_ly(
  data = filtered_brca1,
  x = ~Samples,
  y = ~FPKM,
  type = 'bar',
  color = ~Metastasis,
  colors = c("gray", "orange"),
  text = ~paste("Gene:",Gene,"<br>Tissue:", Tissue, "<br>Metastasis:", Metastasis, "<br>FPKM:", FPKM),
  hoverinfo = 'text',
  textposition = 'inside',
  insidetextanchor = 'middle'
) %>%
  layout(
    title = list(
      text = "Differential expression of BRCA1 based on metastasis",
      font = list(size = 16, color = 'black', family = 'Arial', bold = TRUE),
      xanchor = "center",
      yanchor = "top"
    ),
    xaxis = list(title = "Samples"),
    yaxis = list(title = "FPKM")
  )

# Display the plot
plotly_brca1

#according to the graphs tissues with metastasis status as yes have higher FPKM value 
#compared to tissues with no metastasis case.

#same graph in different format given down below

##barplot3: 
filtered_brca2 <- new_df %>%
  filter(Gene == "BRCA2")

View(filtered_brca2) #total 60

plotly_brca2 <- plot_ly(
  data = filtered_brca2,
  x = ~Samples,
  y = ~FPKM,
  type = 'bar',
  color = ~Metastasis,
  colors = c("gray", "orange"),
  text = ~paste("Gene:",Gene,"<br>Tissue:", Tissue, "<br>Metastasis:", Metastasis, "<br>FPKM:", FPKM),
  hoverinfo = 'text',
  textposition = 'inside',
  insidetextanchor = 'middle'
) %>%
  layout(
    title = list(
      text = "Differential expression of BRCA2 based on metastasis",
      font = list(size = 16, color = 'black', family = 'Arial', bold = TRUE),
      xanchor = "center",
      yanchor = "top"
    ),
    xaxis = list(title = "Samples"),
    yaxis = list(title = "FPKM")
  )

# Display the plot
plotly_brca2

#same conclusion 
#according to the graphs tissues with metastasis status as yes have higher FPKM value 
#compared to tissues with no metastasis case.
