# Purpose: Practice using tidyr with biogeochemistry data from sites in Hawaii with submarine groundwater discharge for Week 04 homework

# Created by: Isabella Kintigh
# Created on: 21 September 2025

################################################################################

#### Open libraries #########

library(tidyverse)
library(here)
library(ggbernie)

## Load in dfs #####################

ChemData <- read.csv(here("Week_04", "Data", "chemicaldata_maunalua.csv"))

## Always look at data 

View(ChemData)
glimpse(ChemData)

#### -------------- Data Clean up -------------------------------- #####

# Remove NAs

ChemData_Clean <- ChemData %>%
  filter(complete.cases(.)) # Filters out everything that is not a complete row

# Always look at data

View(ChemData_Clean)

# Look into separate function

?separate

# Now separate tide_time into two columns

ChemData_Clean <- ChemData %>%
  drop_na() %>% # Filters out everything that is not a complete row
  separate(col = Tide_time, # Choose the tide column
           into = c("Tide", "Time"), # Separate into two columns named Tide and Time
           sep = "_") # Separate by _

# Always look at data 

View(ChemData_Clean)

# Use the unite function

ChemData_Clean <- ChemData %>%
  drop_na() %>%  # Filters out everything that is not a complete row
  separate(col = Tide_time, # Choose the tide column
           into = c("Tide", "Time"), # Separate into two columns named Tide and Time
           sep = "_") %>% # Separate by _
  unite(col = "Site_Zone_Season", # The name of the new column
        c(Site, Zone, Season), # The columns being united
        sep = "_", # Puts a . in the middle
        remove = FALSE) # Keep the original column

# ---------------- Pivoting the data set between wide and long -------------

ChemData_Long <- ChemData_Clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # The columns you want to pivot, says select from temp to percent sgd
               names_to = "Variables", # names of the new columns with all the column names
               values_to = "Values") # Names of the new column with all the values

# Always look at data

View(ChemData_Long)

# Calculate mean and variance for all variables at each site 

ChemData_Long %>%
  group_by(Variables, Site) %>% # Group by the columns we want
  summarise(Param_Means = mean(Values, na.rm = TRUE), # Get mean and ignore NA
            Param_Vars = var(Values, na.rm = TRUE)) # Get variance and ignore NA

# Calculate mean, variance, and standard deviation for all variables by site, zone, and tide

ChemData_Long %>%
  group_by(Variables, Site, Zone, Tide) %>% # Group by everything we want
  summarise(Param_Means = mean(Values, na.rm = TRUE), # Get mean and ignore NA
            Param_Vars = var(Values, na.rm = TRUE), # Get variance and ignore NA
            Param_SD = sd(Values, na.rm = TRUE))

## Pivoting data back to wide 

ChemData_Wide <- ChemData_Long %>%
  pivot_wider(names_from = Variables, # column with the names for the new column
              values_from = Values) # column with the values 

# Always look at the data

glimpse(ChemData_Wide)
  

# -------------------------- Plot -------------------------------

ChemData_Long %>%
  ggplot(aes(x = Site,
             y = Values)) + 
  geom_boxplot() + 
  facet_wrap(~Variables, scales = "free") # Scales makes the scales different, frees the x and the y


# ------------- Calculate summary statistics and export ------------------

ChemData_Clean <- ChemData %>%
  drop_na() %>% # Filters out everything that is not a complete row
  separate(col = Tide_time, # Choose the column
           into = c("Tide", "Time"), # Separate into two columns tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% # Do not remove original column
  pivot_longer(cols = Temp_in:percent_sgd, # Columns we want to pivot
               names_to = "Variables", # The names of the new columns
               values_to = "Values") %>% # Names of the new columns with their values
  
  group_by(Variables, Site, Time) %>% # Columns we want to keep
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% # Add in a mean column
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% # The name we originally had
  write_csv(here("Week_04", "Output", "ChemData_Summary_Kintigh.csv")) # Export to CSV


# ------------- Feel the bern -------------------

ggplot(ChemData) +
  geom_bernie(aes(x = Salinity,
                  y = NN),
              bernie = "sitting")
  
  