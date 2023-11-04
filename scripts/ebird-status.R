library(dplyr)
library(exactextractr)
library(ggplot2)
library(sf)
library(terra)
library(ebirdst)

# get an ebirdst access key https://ebird.org/st/request
# store it using set_ebirdst_access_key("XXXXXXXXX")
# run the following to test the access key
ebirdst_download_status("abetow",
                        pattern = "abundance_median_27km_2022",
                        force = TRUE)


# status species ----

# explore ebirdst_runs

# EXERCISE


# downloading data ----

# download blue-winged teal status data products


# loading data ----

# load blue-winged teal weekly relative abundance

# load confidence intervals

# EXERCISE

# load seasonal relative abundance

# load full year relative abundance


# working with raster data ----

# load 9km relative abundance estimates
abd_weekly <- load_raster("buwtea", product = "abundance", resolution = "9km")
abd_seasonal <- load_raster("buwtea", product = "abundance",
                            period = "seasonal", resolution = "9km")

# subset to a single week or season

# subset to all weeks in november and average

# map for lower mississippi valley joint venture
# polygon for the lower mississippi valley joint venture footprint
lmv_boundary <- paste0("https://github.com/ebird/ebirdst-workshop_tws-2023/",
                       "raw/main/data/boundaries.gpkg") %>%
  read_sf(layer = "lmvjv") %>%
  st_transform(crs = st_crs(abd_seasonal))

# state boundary polygons for mapping
states <- paste0("https://github.com/ebird/ebirdst-workshop_tws-2023/",
                 "raw/main/data/boundaries.gpkg") %>%
  read_sf(layer = "states") %>%
  st_transform(crs = st_crs(abd_seasonal))

# crop and mask the breeding season relative abundance raster

# map
plot(abd_breeding_lmv, axes = FALSE)
plot(st_geometry(states), add = TRUE)


# applications: trajectories ----

# download data for canvasback
ebirdst_download_status("Canvasback", pattern = "_27km_")

# load proportion of population cubes for both species

# calculate weekly proportion of population within lmvjv
# blue-winged teal

# canvasback

# combine

# plot the trajectories
ggplot(trajectories, aes(x = week, y = prop_pop, color = species)) +
  geom_line() +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "Week",
       y = "% of population",
       title = "Weekly % of population trajectory in LMVJV",
       color = NULL) +
  theme(legend.position = "bottom")

# EXERCISE


# applications: prioritization ----

# download data and load non-breeding proportion of population
species_list <- c("buwtea", "canvas", "mallard", "virrai")
proportion_population <- list()
for (species in species_list) {
  # download data where needed, existing files won't be re-downloaded

  # load seasonal proportion of population

  # subset to the nonbreeding season, crop and mask to lmvjv

  # combine with other species
}
# stack the rasters into a single object

# generate importance layer: mean percent of population across species


# plot the square root of importance since the data are right skewed

# identify the 90th quantile of importance


# reclassify the importance raster to highlight the top cells


# map importance
