## This script is to practice using ggplot2 for week 3 of OCN680

## Created by: Isabella Kintigh
## Created on: 9 September 2025

###################################################################################

## Load libraries #################

library(palmerpenguins)
library(tidyverse)

### Getting a visual on the data set before plotting #######

glimpse(penguins)

### Plotting ########################

# This adds the shape = islands to the "simple plot"
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm,
                     color = species,
                     shape = island)) +
  geom_point() +
  labs(title = "Bill Depth and Length", 
       subtitle = "Dimenstions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", 
       y = "Bill Length (mm)", 
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       shape = "Island") +
  scale_colour_viridis_d() # d stands for discrete


# This plot changes the size of the points based on body mass

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm,
                     color = species,
                     size = body_mass_g)) +
  geom_point() +
  labs(title = "Bill Depth and Length", 
       subtitle = "Dimenstions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", 
       y = "Bill Length (mm)", 
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       shape = "Island") +
  scale_colour_viridis_d() # d stands for discrete


# Showing mapping

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm,
                     size = body_mass_g,
                     alpha = flipper_length_mm)) +
  geom_point() +
  labs(title = "Bill Depth and Length", 
       subtitle = "Dimenstions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", 
       y = "Bill Length (mm)", 
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       shape = "Island") +
  scale_colour_viridis_d() # d stands for discrete

# Showing setting

ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm)) +
  geom_point(size = 2, alpha = 0.5) +
  labs(title = "Bill Depth and Length", 
       subtitle = "Dimenstions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill Depth (mm)", 
       y = "Bill Length (mm)", 
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package",
       shape = "Island") +
  scale_colour_viridis_d() # d stands for discrete


##### Faceting ########################

# Facet for sex using facet_grid

ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_grid(species~sex)

# Facet for species using facet_wrap

ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ species)

# Facet for species and setting it to two columns using wrap

ggplot(penguins,
       aes(x = bill_depth_mm, 
           y = bill_length_mm)) +
  geom_point() +
  facet_wrap(~ species, ncol = 2) # 2 columns


# Facet with color

ggplot(penguins, 
       aes(x = bill_depth_mm,
           y = bill_length_mm, color = species)) +
  geom_point() +
  scale_colour_viridis_d() +
  facet_grid(species~sex)

# Facet with color and no legends

ggplot(penguins, 
       aes(x = bill_depth_mm,
           y = bill_length_mm, color = species)) +
  geom_point() +
  scale_colour_viridis_d() +
  facet_grid(species~sex) +
  guides(color = FALSE)



