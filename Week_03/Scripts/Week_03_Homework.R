## This script is to create a plot from scratch the penguin data for my homework assignment for week 3 for OCN 682

## Created by: Isabella Kintigh
## Created on: 14 September 2025

##################################################################################

### Open libraries ####

library(tidyverse)
library(here)
library(palmerpenguins)
library(ggthemes)
library(scales)


### Always glimpse at data first ####

glimpse(penguins)

### Data wrangling #############################################

# Keeping only what is needed, dropping NAs and ordering species for consistency 

penguins_updated <- penguins %>%                # Start from the full penguins data 
  select(species, flipper_length_mm) %>%        # Keep only necessary variables
  filter(!is.na(species),                       # Remove rows missing species
         !is.na(flipper_length_mm)) %>%         # Remove rows missing flipper length
  mutate(species = factor(species,              # Make factors explicit and ordered
                          levels = c("Adelie", "Chinstrap", "Gentoo"))) 

# Show how many penguins are in each species (n) in the caption

n_table <- penguins_updated %>%                 # Use the cleaned data
  count(species, name = "n")                    # Count rows per species

# Since ridgeline shapes can look different when one group has a small sample size there will be a caption string displaying how many data points are in each 

caption_n <- paste0(
  "n: ",
  paste(n_table$species, n_table$n, sep = " = ", collapse = ", ")
)


### Plot ############################################

# Ridgelines show the shape of each group's distribution stacked vertically

penguin_plot <- ggplot(
  penguins_updated,
  aes(x = flipper_length_mm,
      y = species,            # Each species gets its own ridge 
      fill = species)) +
  ggridges::geom_density_ridges(
    scale = 1.1,              # How much the ridges overlap
    alpha = 0.75,             # Make flills slightly see through so overlap is readable
    color = "white",          # Thin white outline to separate the ridges
    size = 0.3) +             # Thickness of the outline
  scale_fill_brewer(
    palette = "Dark2",
    guide = "none") +         # Hide the legend because the species are already on the y-axis
  scale_x_continuous(
    breaks = pretty(penguins_updated$flipper_length_mm), # Asking R for "nice" tick marks
    labels = label_number(accuracy = 1) # Show the whole number mm labels
  ) +
  labs(title = "Flipper Length Distributions by Species",
        subtitle = "Ridgeline densities (non-scatter) using ggridges", # States method/constraint
        x = "Flipper length (mm)",
        y = NULL,               # No y-axis title (species labels suffice)
        caption = paste0("Data: palmerpenguins | ", caption_n)    # Credit and sample sizes
  ) +
  theme_minimal(base_size = 13) +     # Clean theme with readable base font size
  theme(
    panel.grid.minor = element_blank(),    # Remove minor grid to reduce clutter
    plot.title  = element_text(face = "bold"),    # Emphasize title
    plot.subtitle    = element_text(color = "gray25")  # Subtle, secondary emphasis
  )

#### Save plot ######################

ggsave(here("Week_03", "Output", "homework_week03_kintigh.png"),
       width = 7,
       height = 5,
       bg = "white")






