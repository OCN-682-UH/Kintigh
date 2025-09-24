
# Purpose: Practice joins with data from Becker and Silbiger

# Created by: Isabella Kintigh
# Created on: 23 September 2025

##############################################################################

#### Open libraries #########

library(tidyverse)
library(here)
library(cowsay)

# ---------------------- Load data ------------------------------------

# Envrionmental data from each site

EnviroData <- read_csv(here("Week_05", "Data", "site.characteristics.data.csv"))

# Thermal performance data 
 
TPCData <- read_csv(here("Week_05", "Data", "Topt_data.csv"))                      

# --------------------- Clean up data -----------------------------------

EnviroData_Wide <- EnviroData %>%
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>%
  arrange(site.letter)

# Join with join by left join

FullData_Left <- left_join(TPCData, EnviroData_Wide) %>%
  relocate(where(is.numeric), .after = where(is.character))

# Calculate mean and variance of all collected data by site

FullData_Left_Long <- FullData_Left %>%
  pivot_longer(c(E:substrate.cover),
               names_to  = "Variable",
               values_to = "Value")  %>%
  group_by(site.letter, Variable) %>%
  summarise(mean = mean(Value, na.rm = TRUE),
            variance = var(Value, na.rm = TRUE))

# --------------------- Make a tibble ----------------------------------

T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))

T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))

# Left join

left_join(T1, T2)

# Right join

right_join(T1, T2)

# Inner join

inner_join(T1, T2)

# Full join

full_join(T1, T2)

# Semi join

semi_join(T1, T2)

# Anti join

anti_join(T1, T2)


# ------------ Cow say -------------------

say("hello", by = "alligator")

?cowsay
