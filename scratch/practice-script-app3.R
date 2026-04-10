#..............................SETUP.............................

# load packages ----
library(arrow)
library(tidyverse)
library(leaflet)

# read in data ----
lake_data <- read_parquet(here::here("shinydashboard", "data", "lake_data_processed.parquet"))

#.......................PRACTICE FILTERING.......................

filtered_lakes_df <- lake_data |> 
  filter(Elevation >= 8 & Elevation <= 20) |> 
  filter(AvgDepth >= 2 & AvgDepth <= 3) |> 
  filter(AvgTemp >= 4 & AvgTemp <= 6)

#..........................PRACTICE VIZ..........................

leaflet() |> 
  
  # add tiles
  addProviderTiles(providers$Esri.WorldImagery, # make note of using appropriate tiles
                   options = providerTileOptions(maxNativeZoom = 19, maxZoom = 100)) |> 
  
  # add mini map
  addMiniMap(toggleDisplay = TRUE, minimized = TRUE) |> 
  
  # set view over AK
  setView(lng = -152.048442, lat = 70.249234, zoom = 6) |> 
  
  # add markers
  addMarkers(data = filtered_lakes_df,
             lng = filtered_lakes_df$Longitude, lat = filtered_lakes_df$Latitude,
             popup = paste0(
               "Site Name: ", filtered_lakes_df$Site, "<br>",
                            
               "Elevation: ", filtered_lakes_df$Elevation, " meters (above SL)", "<br>",
                            
               "Avg Depth: ", filtered_lakes_df$AvgDepth, " meters", "<br>",
                            
               "Avg Lake Bed Temperature: ", filtered_lakes_df$AvgTemp, "°C")) 

# NOTE: Shift + Option + 8 (mac), Alt + 0176 (Windows), or use unicode "\u00B0C"
