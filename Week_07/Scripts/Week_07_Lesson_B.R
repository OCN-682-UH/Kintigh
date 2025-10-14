# Purpose: Map plots in R using GGMap
# Isabella Kintigh
# 12 October 2025

# ----------------------------------------------------------

# ----------- Open libraries --------------------------------

library(tidyverse)
library(lubridate)
library(data.table)
library(ggrepel)
library(ggmap)
library(here)
library(ggspatial)

# ----------- Load in df ------------------------------

ChemData <- read.csv(here("Week_07", "Data", "chemicaldata_maunalua.csv"))

# ------------- Look at the data sets ----------------

# Location as a string 

Oahu <- get_map("Oahu")

# Actually looking at the map

ggmap(Oahu)

#Make a data frame of lon and lat coordinates

WP <- data.frame(lon = -157.7621, lat = 21.27427) # coordinates for Wailupe

# Get base layer

Map1 <- get_map(WP)

# plot it

ggmap(Map1)

# Zoom 

Map1 <- get_map(WP,
                zoom = 17,
                maptype = "satellite")

ggmap(Map1)+
  geom_point(data = ChemData,
             aes(x = Long, y = Lat, color = Salinity),
             size = 4) +
  scale_color_viridis_c()

ggmap(Map1)

# Map with scale and N arrow 

ggmap(Map1)+
  geom_point(data = ChemData, 
             aes(x = Long, y = Lat, color = Salinity), 
             size = 4) + 
  scale_color_viridis_c()+
  annotation_scale( bar_cols = c("red", "white"),
                    location = "bl")+ # put the bar on the bottom left and make the colors yellow and white
  annotation_north_arrow(location = "tl")+ # add a north arrow
  coord_sf(crs = 4326) # for the scale bar to work it needs to be in this coordinate system - this is a typical coordinate reference system for a GPS (WGS84)


