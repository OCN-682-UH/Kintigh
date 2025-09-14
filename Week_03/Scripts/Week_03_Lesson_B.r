## This script is to plot penguin data for lesson B of week 3 for OCN 682

## Created by: Isabella Kintigh
## Created on: 13 September 2025

###################################################################################

## Load libraries #################

library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
library(beyonce)
library(ggthemes)

### Getting a visual on the data set before plotting #######

glimpse(penguins)

### Plotting with penguins ########################

# Start with a simple plot part 1

ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     group = species, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)") +
  scale_colour_viridis_d() +
  scale_x_continuous(limits = c(0,20)) +
  scale_y_continuous(limits = c(0,50))


# Simple plot part 2: focused on splitting data

ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     group = species, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)") +
  scale_colour_viridis_d() +
  scale_x_continuous(breaks = c(14, 17, 21),
                     labels = c("low", "medium", "high"))

# Simple plot 3: focused on color scales 

ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     group = species, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)") +
  scale_color_manual(values = beyonce_palette(11)) +
  coord_flip()

# Simple plot 4: focused on coordinate

ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     group = species, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)") +
  scale_color_manual(values = beyonce_palette(11)) +
  theme_wsj() +
  theme(axis.title = element_text(size = 20,
                                  color = "black"),
        panel.background = element_rect(fill = "linen")) 


# Test plot using different elements from theme 

ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     group = species, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)") +
  scale_color_manual(values = beyonce_palette(11)) +
  theme(legend.position = "top", 
          legend.title = element_blank(),
          legend.background = element_rect(fill = "white", color = "black"),
        axis.title = element_text(size = 20)) +
  annotate("rect", 
           xmin = 15, 
           xmax = 20, 
           ymin = 40, 
           ymax = 50, 
           fill = "lightblue", 
           alpha = 0.2)


### Plotting with diamonds ########################

# First take a quick look at the data

glimpse(diamonds)

# Now start with a simple plot that "logs" the data to make it a better visual

ggplot(diamonds, 
       aes(log(carat), log(price))) + 
  geom_point()

# A simple plot that logs the axes instead of the data 

ggplot(diamonds,
       aes(x = carat, 
           y = price)) +
  geom_point() +
  coord_trans(x = "log10",
              y = "log10")



#### Save the test plot ########

ggsave(here("Week_03", "Output", "penguin_kintigh.pdf"),
       width = 7,
       height = 5)

#### Save plot as an object #######

plot_1 <- ggplot(data = penguins, 
       mapping = aes(x = bill_depth_mm, 
                     y = bill_length_mm, 
                     group = species, 
                     color = species)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)") +
  scale_color_manual(values = beyonce_palette(11)) +
  theme(legend.position = "top", 
        legend.title = element_blank(),
        legend.background = element_rect(fill = "white", color = "black"),
        axis.title = element_text(size = 20)) +
  annotate("rect", 
           xmin = 15, 
           xmax = 20, 
           ymin = 40, 
           ymax = 50, 
           fill = "lightblue", 
           alpha = 0.2)



