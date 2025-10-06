# My Quarto Practice 2
Bella Kintigh

<script src="Week_06_Lesson_B_files/libs/kePrint-0.0.1/kePrint.js"></script>
<link href="Week_06_Lesson_B_files/libs/lightable-0.0.1/lightable.css" rel="stylesheet" />

# Introduction

Today we are learning how to work with figures in Quarto for OCN 682.

## Load the libraries

``` r
library(tidyverse)
library(here)
library(palmerpenguins)
library(kableExtra)
```

# Make a plot

``` r
library(palmerpenguins)
library(tidyverse)

penguins %>%
  ggplot(aes(x = bill_length_mm, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()
```

<div id="fig-penguin">

<img src="../Output/fig-penguin-1.png" style="width:70.0%"
data-fig-align="center" />

Figure 1: This figure shows length by bill depth

</div>

When you look at <a href="#fig-penguin" class="quarto-xref">Figure 1</a>
you can see there is a positive relationship between bill length and
bill depth

# Practice Table

| Time   | Session  |   Topic |
|:-------|:--------:|--------:|
| *left* | *center* | *right* |
| 01:00  |    1     | Anatomy |
| 01:50  |          | *Break* |
| 02:00  |    2     |  Tables |
| 02:45  |          | *Break* |

# Table with kable

``` r
library(kableExtra)
library(palmerpenguins)
library(tidyverse)

penguins %>%
  group_by(species) %>%
  summarise(billmean = mean(bill_length_mm, na.rm = TRUE)) %>%
  kbl() # make it a kable table
```

<div id="tbl-penguin">

Table 1: My awesome penguin table

<div class="cell-output-display">

| species   | billmean |
|:----------|---------:|
| Adelie    | 38.79139 |
| Chinstrap | 48.83382 |
| Gentoo    | 47.50488 |

</div>

</div>

Table <a href="#tbl-penguin" class="quarto-xref">Table 1</a> has
information on the mean bill length by species.

# Add Some Flair to the Table

``` r
library(kableExtra)
library(palmerpenguins)
library(tidyverse)

penguins %>%
  group_by(species) %>%
  summarise(billmean = round(mean(bill_length_mm, na.rm = TRUE))) %>%
  kbl()  %>% # make it a kable table
  kable_classic() %>% # add a theme
  row_spec(2, bold = TRUE, color = "white", background = "blue") %>% # highlight row 2
  kable_styling(full_width = FALSE) # don't make it so wide
```

| species   | billmean |
|:----------|---------:|
| Adelie    |       39 |
| Chinstrap |       49 |
| Gentoo    |       48 |
