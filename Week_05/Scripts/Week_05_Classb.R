
# Purpose: Practice using lubridate for class lecture b for week 5 of OCN 682

# Created by: Isabella Kintigh
# Created on: 28 September 2025

##############################################################################

#### Open libraries #########

library(tidyverse)
library(here)
library(lubridate)
library(devtools)

# ---------------------- Load data ------------------------------------

Depth <- read_csv(here("Week_05", "Data", "DepthData.csv"))

Cond <- read_csv(here("Week_05", "Data", "CondData.csv"))


# ------------------- Practice using lubridate -------------------------

# Date specifications 

ymd("2021-02-24")

mdy("02/24/2021")

# Date and time specificatios

ymd_hms("2021-02-24 10:22:20 PM")

mdy_hms("02/24/2021 22:22:20")

# Extracting specific date or time elements from datetimes
# Note the vector must all be in the same format (m/d/y or d/m/y)

datetimes <- c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")

# Convert date times

datetimes <- mdy_hms(datetimes)

# Extract months 

month(datetimes, label = TRUE, abbr = FALSE)

# Extract day

day(datetimes)

# Extract week day

wday(datetimes, label = TRUE)

# Adding dates and times

datetimes + hours(4) # this adds 4 hours also note the added s to hour

datetimes + days(2) # this adds 2 days

# Rounding dates

round_date(datetimes, "minute") # round to nearest minute


# ----------------- Cond data ------------------------------------

Cond_Clean <- Cond %>%
  mutate(date = mdy_hms(date))










