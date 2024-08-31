# This script creates a tree map using the USPersonalExpenditure dataset and
# groups the data buy Year and Categories.

# Install packages
install.packages("datasets")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("treemapify")


# Load necessary libraries
library(datasets)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(treemapify)

# Use the built-in US Personal Expenditure data set
df <- as.data.frame(USPersonalExpenditure)

#Create Categories variable from the row names
df$Categories <- rownames(df)

# Pivot data to make it tidy
df_tidy = pivot_longer(
  df,
  cols = -Categories,
  names_to = "Year",
  values_to = "Expenditure_Amount",
  cols_vary = "fastest"
)

# plot treemap
ggplot(
  df_tidy,
  aes(
    area = Expenditure_Amount,
    fill = Categories,
    label = Categories,
    subgroup = Year
  )
) +
  geom_treemap() +
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(
    place = "bottom",
    grow = FALSE,
    reflow = TRUE,
    alpha = 0.5,
    colour = "black",
    fontface = "italic"
  ) +
  geom_treemap_text(
    col = "white",
    place = "center",
    grow = FALSE,
    reflow = TRUE
  )
