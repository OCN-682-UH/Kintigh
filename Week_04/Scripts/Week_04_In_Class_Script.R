## Purpose: This script is to practice using dplyr in week 4 with penguin data

## Created by: Isabella Kintigh
## Created on: 16 September 2025

################################################################################

#### Open libraries #########

library(tidyverse)
library(palmerpenguins)
library(here)
library(devtools)

### Load data ###########

# This data is part of the package and is called penguins

glimpse(penguins)

names(penguins)


##### Using filter ##########

# Extract rows that meet some criteria

filter(.data = penguins, sex == "female")

filter(.data = penguins, year == 2008)

filter(.data = penguins, body_mass_g > 5000)

filter(.data = penguins, sex == "female", body_mass_g > 500)

filter(.data = penguins, sex == "female" & body_mass_g > 500)

# Using the either operator for penguins collected in either 2008 or 2009

penguins %>%
  filter(year == 2008) %>%
  filter(year == 2009)


# Using the not operator for penguins not from the island dream

penguins %>%
  filter(island != "Dream")

# Using the within operator for penguins that are in species and Adelie and Gentoo

penguins %>%
  filter(species %in% c("Adelie", "Gentoo"))

##### Using mutate #############

# Add new column converting body mass in grams to kg 

data2 <- penguins %>%
  mutate(body_mass_kg = body_mass_g/1000)

# Add new column converting body mass in grams to kg and calculate ratio of bill length to depth 

data2 <- penguins %>%
  mutate(body_mass_kg = body_mass_g/1000) %>%
  mutate(bill_length_depth = bill_length_mm/bill_depth_mm)

# Using mutate and ifelse 

data2 <- penguins %>%
  mutate(after_2008 = ifelse(year > 2008, 
                             "After 2008", 
                             "Before 2008"))

# Add flipper legnth and body mass together 

data2 <- penguins %>%
  mutate(length_mass = flipper_length_mm + body_mass_g)

# Use ifelse and mutate to create a new column wehre body mass greater than 4000 is labelled as big and everything else is small

data2 <- penguins %>%
  mutate(body_mass_g_l = ifelse(body_mass_g > 4000,
                                "Big",
                                "Small"))


##### Using pipe!! ########

# Filter only female penguins and add a new column that calculates the log body mass

penguins %>% 
  filter(sex == "female") %>% # select females
  mutate(log_mass = log(body_mass_g)) # calculate log biomass


# Use select to select certain columns to remain in the dataframe

penguins %>% 
  filter(sex == "female") %>% # select females
  mutate(log_mass = log(body_mass_g)) %>% # calculate log biomass 
  select(species, island, sex, log_mass)

# Use select to rename things 

penguins %>% 
  filter(sex == "female") %>% # select females
  mutate(log_mass = log(body_mass_g)) %>% # calculate log biomass 
  select(Species = species, island, sex, log_mass)

# Summarise

penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE))

# Calculate mean and mean flipper length

penguins %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE),
  min_flipper = min(flipper_length_mm, na.rm = TRUE))

# Group by

penguins %>%
  group_by(island) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm = TRUE))

penguins %>%
  group_by(island, sex) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm = TRUE))

penguins %>%
  drop_na(sex)


penguins %>%
  drop_na(sex) %>%
  group_by(island, sex) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE))

# Pipe into ggplot

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex,
             y = flipper_length_mm)) +
  geom_boxplot()








