# Purpose: 

# Created by: Isabella Kintigh
# Created on: 23 November 2025

###################################################################

# ------------------------------ Libraries -----------------------------------

library(tidyverse)
library(here)

# ----------------------------- Load in dfs ---------------------------------

# Define the folder path where the .csv files live
tide <- here("Week_13", "Data", "Homework")

# List all CSV files in that folder
files <- dir(path = tide, pattern = ".csv")

# Prepend the full path to each filename
files_full <- file.path(tide, files)

# ------------------------------ For Loop -----------------------------------

# Create empty list to store results
for_results <- list()

# Loop through each file
for (i in seq_along(files_full)) {
  # Read in the CSV file at position i (full file path)
  df <- read_csv(files_full[i])
  
  # Create an ID for the tide pool (e.g., TP1, TP2, etc.)
  pool_id <- paste0("TP", i)
  
  # Calculate summary statistics for temp and light intensity
  summary_stats <- df %>%
    summarise(
      mean_temp = mean(Temp.C, na.rm = TRUE), # mean temp
      sd_temp = sd(Temp.C, na.rm = TRUE), # standard deviation for temp
      mean_light = mean(Intensity.lux, na.rm = TRUE), # mean light intensity
      sd_light = sd(Intensity.lux, na.rm = TRUE) # standard deviation for light intensity
    ) %>%
    mutate(pool = pool_id) # add in a column for pool id 
  
  # Store this summary in the results list
  for_results[[i]] <- summary_stats 
}

# Combine into one tibble
for_loop_summary <- bind_rows(for_results)

# ------------------------------ Map -----------------------------------

# Function to summarize one CSV
# Define a function to summarize each CSV file
summarize_pool <- function(file_path) {
  
  # Read the CSV file from the provided path into a dataframe
  df <- read_csv(file_path)
  
  # Extract just the file name (e.g., "TP1.csv"), remove the ".csv" extension
  pool_id <- tools::file_path_sans_ext(basename(file_path))
  
  # calculate summary statistics for temp and light intensity
  df %>%
    summarise(
      mean_temp = mean(Temp.C, na.rm = TRUE), # mean temp
      sd_temp = sd(Temp.C, na.rm = TRUE), # standard deviation for temp
      mean_light = mean(Intensity.lux, na.rm = TRUE), # mean light intensity
      sd_light = sd(Intensity.lux, na.rm = TRUE) # standard deviation for light intensity
      ) %>%
    mutate(pool = pool_id) # add in a column for pool id 
}

# Use purrr::map_dfr to apply the function to each file
map_summary <- map_dfr(files_full, summarize_pool)










