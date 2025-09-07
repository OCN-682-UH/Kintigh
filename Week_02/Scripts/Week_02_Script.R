## While this is not my first script, this is my first script within Nyssa's class and I am building on my data importing skills.

## Created by: Isabella Kintigh
## Created on: 6 September 2025

###################################################################################

## Load libraries #################

library(tidyverse)
library(here)

### Read in data ######

WeightData <- read_csv(here("Week_02","Data","weightdata.csv"))

### Data Analysis #####

head(WeightData) # This looks at the top six lines of data

tail(WeightData) # This looks at the bottom six lines of data 

View(WeightData) # This opens the df in a new window to look at the entire thing
