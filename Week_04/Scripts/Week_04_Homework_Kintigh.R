
# Purpose: Practice using tidyr with biogeochemistry data from sites in Hawaii with submarine groundwater discharge for Week 04 homework

# Created by: Isabella Kintigh
# Created on: 21 September 2025

################################################################################

#### Open libraries #########

library(tidyverse)
library(here)
library(ggbernie)
library(ggridges)

## Load in dfs #####################

ChemData <- read.csv(here("Week_04", "Data", "chemicaldata_maunalua.csv"))

## Always look at data 

View(ChemData)
glimpse(ChemData)

#### -------------- Data Clean up -------------------------------- #####


# In this I am changing the data from wide format to long and subsetting for only season, variable, and value

chem_long <- ChemData %>%
  pivot_longer( # Change format from wide to long
    cols = c(Temp_in, Salinity, Phosphate, Silicate, NN, pH, TA, percent_sgd),
    names_to  = "Variable",
    values_to = "Value"
  ) %>%
  separate(col = Tide_time, # Choose the tide column
           into = c("Tide", "Time"), # Separate into two columns named Tide and Time
           sep = "_") %>% # Separate by _ 
  drop_na(Season, Value) %>%
  select(Season, Variable, Value) # Keep only COLUMNS I need 

# ------------------ Plot --------------------------------------

# Ridgeline using the subsetted data 

p_ridge <- ggplot(chem_long, aes(x = Value, 
                                 y = Season, 
                                 fill = Season)) +
  geom_density_ridges(alpha = 0.75, 
                      color = "white", 
                      linewidth = 0.3, 
                      scale = 1.1) +
  facet_wrap(~ Variable, 
             scales = "free_x", 
             ncol = 3) +
  labs(title = "Distributions of Chemistry Variables by Season",
       x = "Value", 
       y = "Season", 
       fill = "Season") +
  theme_ridges() +
  theme(text = element_text(size = 12),
        strip.text = element_text(face = "bold"),
        plot.title = element_text(face = "bold"))


# ---------------------- Export plot and csv ---------------------------

# Export plot

ggsave(here("Week_04", "Output", "Homework_Week04_Kintigh.png"),
       plot = p_ridge,
       width = 7,
       height = 5,
       bg = "white")


# Export csv

write_csv(chem_long, here("Week_04", "Output", "ChemData_Long_Homework_Kintigh.csv"))




