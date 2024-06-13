library(dplyr) #it is small part of tidyverse, used for manipulating dataframes
library(tidyverse) #providing tools for data manipulation, visualization, and analysis.
library(ggplot2) #to create different graphs
library(plotly) #used for creating interactive
library(Hmisc)


#fetch current dir
getwd() #currently it is "C:/Users/Nikita Maurya/OneDrive/Documents"

#changing directory
setwd("C:/Users/Nikita Maurya/OneDrive/Desktop/Nikita/Rfiles")

##########data visualization######

new_df = data = read.csv("new_df.csv")

dim(new_df)

##barplot 1: # Plot for BRCA1 and BRCA2 expression

plot_brca <- new_df %>%
  filter(Gene == "BRCA1" | Gene == "BRCA2") %>%
  ggplot(aes(x = Samples, y = FPKM, fill = Gene, text = paste("Tissue:", Tissue, "<br>Metastasis:", Metastasis))) +
  geom_bar(stat = "identity", position = "stack") +
  geom_text(aes(label = FPKM), vjust = -0.3, size = 2, color = "black", 
            position = position_stack(vjust = 0.5)) + 
  labs(x = "Samples", y = "FPKM", title = "Differential expression of BRCA1 and BRCA2 across all samples") +
  scale_fill_manual(values = c("gray", "orange")) + 
  theme_minimal()

plotly_brca <- ggplotly(plot_brca) # Converting ggplot to plotly

plotly_brca #to view plot

#clearly shows higher expression of BRCA1 compared to BRCA2 across all samples.

#barplot 2: BRCA1 expression with metastasis status

plot_brca1 <- new_df %>%
  filter(Gene == "BRCA1") %>%
  ggplot(aes(x = Samples, y = FPKM, fill = Tissue,text = paste("Metastasis:", Metastasis))) +
  geom_col() +
  geom_text(aes(label = FPKM), vjust = -0.5, color = "black", size = 2) +
  labs(x = "Samples", y = "FPKM", title = "Differential Expression of BRCA1") +
  theme_minimal() +
  facet_grid(Tissue ~ Metastasis)

plotly_brca1 <- ggplotly(plot_brca1)

plotly_brca1



##barplot3: 

plot_brca2 <- new_df %>%
  filter(Gene == "BRCA2") %>%
  ggplot(aes(x = Samples, y = FPKM, fill = Tissue,text = paste("Metastasis:", Metastasis))) +
  geom_col() +
  geom_text(aes(label = FPKM), vjust = -0.5, color = "black", size = 2) +
  labs(x = "Samples", y = "FPKM", title = "Differential Expression of BRCA2") +
  theme_minimal() +
  facet_grid(Tissue ~ Metastasis)

plotly_brca2 <- ggplotly(plot_brca2)

plotly_brca2

##### dataframe containing brca1 expressed in breast tumor with metastasis status yes 

df_brca1_BT_meta <- new_df %>%
  filter(Gene == "BRCA1" & Tissue == "breast tumor" & Metastasis == "yes") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca1_BT_meta$groups <- cut(df_brca1_BT_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca1_BT_meta)


df_brca1_BT_with_meta <- as.data.frame(table(df_brca1_BT_meta$groups))
names(df_brca1_BT_with_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca1_BT_with_meta)

##### dataframe containing brca1 expressed in normal breast tissue with metastasis status yes

df_brca1_nbt_meta <- new_df %>%
  filter(Gene == "BRCA1" & Tissue == "normal breast tissue" & Metastasis == "yes") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca1_nbt_meta$groups <- cut(df_brca1_nbt_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca1_nbt_meta)


df_brca1_nbt_with_meta <- as.data.frame(table(df_brca1_nbt_meta$groups))
names(df_brca1_nbt_with_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca1_nbt_with_meta)

############# dataframe containing brca1 expressed in breast tumor without metastasis status

df_brca1_BT_no_meta <- new_df %>%
  filter(Gene == "BRCA1" & Tissue == "breast tumor" & Metastasis == "no") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca1_BT_no_meta$groups <- cut(df_brca1_BT_no_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca1_BT_no_meta)


df_brca1_BT_with_no_meta <- as.data.frame(table(df_brca1_BT_no_meta$groups))
names(df_brca1_BT_with_no_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca1_BT_with_no_meta)


############# dataframe containing brca1 expressed in normal breast tissue without metastasis status

df_brca1_nbt_no_meta <- new_df %>%
  filter(Gene == "BRCA1" & Tissue == "normal breast tissue" & Metastasis == "no") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca1_nbt_no_meta$groups <- cut(df_brca1_nbt_no_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca1_nbt_no_meta)


df_brca1_nbt_with_no_meta <- as.data.frame(table(df_brca1_nbt_no_meta$groups))
names(df_brca1_nbt_with_no_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca1_nbt_with_no_meta)



df_brca1_BT_with_meta$Title <- "Breast Tumor with Metastasis"
df_brca1_BT_with_no_meta$Title <- "Breast Tumor without Metastasis"
df_brca1_nbt_with_meta$Title <- "Normal breast tissue with Metastasis"
df_brca1_nbt_with_no_meta$Title <- "Normal breast tissue without Metastasis"

view(df_brca1_BT_with_meta) 
view(df_brca1_BT_with_no_meta)
view(df_brca1_nbt_with_meta)
view(df_brca1_nbt_with_no_met)


# Combine dataframes
combined_df <- bind_rows(df_brca1_BT_with_meta, df_brca1_BT_with_no_meta, df_brca1_nbt_with_meta, df_brca1_nbt_with_no_meta)

# Print combined dataframe
View(combined_df)

#BRCA1 is more expressed in samples with metastasis.Among them, FPKM values of breast tumor samples with metastasis are higher.  


##### dataframe containing brca2 expressed in breast tumor with metastasis status yes 

df_brca2_BT_meta <- new_df %>%
  filter(Gene == "BRCA2" & Tissue == "breast tumor" & Metastasis == "yes") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca2_BT_meta$groups <- cut(df_brca2_BT_meta$FPKM, breaks = bins, labels = bin_labels)

View(df_brca2_BT_meta)


df_brca2_BT_with_meta <- as.data.frame(table(df_brca2_BT_meta$groups))
names(df_brca2_BT_with_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca2_BT_with_meta)

##### dataframe containing brca1 expressed in normal breast tissue with metastasis status yes

df_brca2_nbt_meta <- new_df %>%
  filter(Gene == "BRCA2" & Tissue == "normal breast tissue" & Metastasis == "yes") %>%
  arrange(FPKM)  

bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca2_nbt_meta$groups <- cut(df_brca2_nbt_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca2_nbt_meta)


df_brca2_nbt_with_meta <- as.data.frame(table(df_brca2_nbt_meta$groups))

View(df_brca2_nbt_with_meta)

names(df_brca2_nbt_with_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca2_nbt_with_meta)

############# dataframe containing brca1 expressed in breast tumor without metastasis status

df_brca2_BT_no_meta <- new_df %>%
  filter(Gene == "BRCA2" & Tissue == "breast tumor" & Metastasis == "no") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca2_BT_no_meta$groups <- cut(df_brca2_BT_no_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca2_BT_no_meta)


df_brca2_BT_with_no_meta <- as.data.frame(table(df_brca2_BT_no_meta$groups))
names(df_brca2_BT_with_no_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca2_BT_with_no_meta)


############# dataframe containing brca1 expressed in normal breast tissue without metastasis status

df_brca2_nbt_no_meta <- new_df %>%
  filter(Gene == "BRCA2" & Tissue == "normal breast tissue" & Metastasis == "no") %>%
  arrange(FPKM)  


bins <- c(0, 10, 20, 30, 40, Inf)  


bin_labels <- c("0-10", "11-20","21-30" ,"31-40", "Above 40")


df_brca2_nbt_no_meta$groups <- cut(df_brca2_nbt_no_meta$FPKM, breaks = bins, labels = bin_labels)


View(df_brca2_nbt_no_meta)


df_brca2_nbt_with_no_meta <- as.data.frame(table(df_brca2_nbt_no_meta$groups))
names(df_brca2_nbt_with_no_meta) <- c("FPKM Value", "No_of_Samples")
View(df_brca2_nbt_with_no_meta)



df_brca2_BT_with_meta$Title <- "Breast Tumor with Metastasis"
df_brca2_BT_with_no_meta$Title <- "Breast Tumor without Metastasis"
df_brca2_nbt_with_meta$Title <- "Normal breast tissue with Metastasis"
df_brca2_nbt_with_no_meta$Title <- "Normal breast tissue without Metastasis"

#view(df_brca2_BT_with_meta) 
#view(df_brca2_BT_with_no_meta)
#view(df_brca2_nbt_with_meta)
#view(df_brca2_nbt_with_no_meta)


combined_df2 = bind_rows(df_brca2_BT_with_meta,df_brca2_BT_with_no_meta,df_brca2_nbt_with_meta,df_brca2_nbt_with_no_meta)

View(combined_df2)

#brca2 is expressed lesser than BRCA1. Samples with metastasis have higher expresssion.

