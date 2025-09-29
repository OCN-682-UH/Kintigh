
# Purpose: Practice using lubridate for homework for week 5 of OCN 682

# Created by: Isabella Kintigh
# Created on: 28 September 2025

##############################################################################

#### Open libraries #########

library(tidyverse)
library(here)
library(lubridate)
library(ggthemes)
library(NatParksPalettes)

# ---------------------- Load data ------------------------------------

Depth <- read_csv(here("Week_05", "Data", "DepthData.csv"))

Cond <- read_csv(here("Week_05", "Data", "CondData.csv"))



# ------------------- Clean data, join, and plot -------------------------

# No need to clean up depth because the date is already in the proper format
# Join the two dfs (depth and cond) but only where there are exact matches so that would be inner join

Cond_Depth <- Cond %>%
  mutate(date = mdy_hms(date), # Change date to proper format
         Rounded_Date = round_date(date, "10 second")) %>% # Round date to join
  inner_join(Depth, by = c("Rounded_Date" = "date")) %>% # Join data
  mutate(minute = floor_date(Rounded_Date, "minute")) %>% # Round to minute
  group_by(minute) %>% # accompanied by minute so when we do our summarise function it is by minute
  summarise(date = first(minute), # use as representative time
            depth_avg = mean(Depth, na.rm = TRUE), # average depth
            temp_avg = mean(Temperature, na.rm = TRUE), # average temp
            salinity_avg = mean(Salinity, na.rm = TRUE)) # average salinity

# ----------------------------- Write csv  --------------------------------

write_csv(Cond_Depth, here("Week_05", "Output", "Cond_Depth_Avg_Minute.csv"))

# -------------------- Plot and pivotting longer -----------------

density_plot <- Cond_Depth %>%
  select(depth_avg, # Keep only the three variables for the plot
         temp_avg, 
         salinity_avg) %>%
  pivot_longer(everything(), # go from a wide table to long
               names_to = "variable", 
               values_to = "value") %>%
  mutate(variable = recode(variable, # Add pretty names
                           depth_avg = "Depth (m)", 
                           temp_avg = "Temperature (°C)", 
                           salinity_avg = "Salinity")) %>%
  ggplot(aes(x = value, 
             fill = variable)) +
  geom_density(alpha = 0.7, 
               linewidth = 0.6, 
               adjust = 1.1) + # Smooths bandwidth 
  facet_wrap(~ variable, # one small multiple panel per variable
             scales = "free_x", # Each plot gets its own x-axis
             nrow = 1) + # Arrange panels in one row
  scale_fill_natparks_d("Arches2", # palette
                        guide = "none") +  # Hide legend
  labs(title = "Distribution of Minute-Averaged Sensor Readings", 
       x = "Value", 
       y = "Density") +
  ggthemes::theme_wsj(base_size = 13, 
                      color = "black") +
  theme(
    panel.grid.major.y = element_blank(),
    strip.text = element_text(face = "bold"),
    legend.position = "none"
  )


# ----------------------- Save plot ------------------------------------

ggsave(here("Week_05",
            "Output",
            "Minute_Average_Densities_Kintigh.png"),
       density_plot, 
       width = 14, 
       height = 4.6, 
       dpi = 300,
       bg = "white")



