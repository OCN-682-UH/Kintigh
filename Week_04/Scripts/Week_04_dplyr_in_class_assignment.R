## This script is to practice using dplyr in week 4, for the 4a dplyr assignment

## Created by: Isabella Kintigh
## Created on: 16 September 2025

################################################################################

#### Open libraries #########

library(tidyverse)
library(palmerpenguins)
library(here)
library(devtools)


##### Assignment ###########################################

# Mean and variance of body mass by species, island, and sex and drop NAs

penguins_stats <- penguins %>%
  drop_na(species, island, sex, body_mass_g) %>%   # ensure no NAs
  group_by(species, island, sex) %>%   # Used in combination with summarise
  summarise(                # Calculations for mean body mass and variance
    mean_body_mass_g = mean(body_mass_g),
    var_body_mass_g  = var(body_mass_g),
    n = n(),
    .groups = "drop"
  )

# Quick glipse at the new df 

glimpse(penguins_stats)

# Filter out male penguins, compute log body mass, and keep only required columns

penguins_log <- penguins %>% 
  filter(sex == "female") %>%     # exclude males
  drop_na(species, island, sex, body_mass_g) %>%    # remove NAs
  mutate(log_body_mass = log(body_mass_g)) %>%    # compute log body mass
  select(species, island, sex, log_body_mass)    # keep only these columns



###### Plot ###########

plot_log_mass <- ggplot(
  penguins_log,
  aes(x = species, y = log_body_mass)
) +
  geom_boxplot() +
  labs(
    title = "Log Body Mass of Female Penguins by Species",
    x = "Species",
    y = "log(Body mass in grams)",
    caption = "Source: palmerpenguins package"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    strip.text = element_text(face = "bold")
  )


plot_log_mass

# Save plot

ggsave(
  filename = here::here("Week_04", 
                        "Output", 
                        "log_body_mass_female_penguins_kintigh.png"),
  plot     = plot_log_mass,   
  width    = 8,
  height   = 5,
  units    = "in",
  dpi      = 300,
  bg       = "white"
)



