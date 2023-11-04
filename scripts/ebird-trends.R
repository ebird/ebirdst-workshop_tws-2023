library(dplyr)
library(ggplot2)
library(sf)
library(terra)
library(ebirdst)

# trends species ----

trends_runs <- ebirdst_runs %>%
  filter(has_trends) %>%
  select(species_code, common_name,
         trends_season, trends_region,
         trends_start_year, trends_end_year,
         trends_start_date, trends_end_date,
         rsquared, beta0)

# dates and years for canvasback


# downloading and loading data ----

# download data for sage thrasher

# load sage thrasher data

# EXERCISE


# conversion to spatial ----

# convert to sf points

# convert to raster

# make a map of raster data
# define breaks and palettes similar to those on s&t website
breaks <- seq(-4, 4)
breaks[1] <- -Inf
breaks[length(breaks)] <- Inf
pal <- ebirdst_palettes(length(breaks) - 1, type = "trends")

# make a simple map
plot(ppy_raster[["abd_ppy"]],
     col = pal, breaks =  breaks,
     main = "Trend in relative abundance 2012-2022 [% change per year]",
     cex.main = 0.75,
     axes = FALSE)


# uncertainty ----

# load fold-level data


# applications: regional trends ----

# boundaries of states in the united states
states <- paste0("https://github.com/ebird/ebirdst-workshop_tws-2023/",
                 "raw/main/data/boundaries.gpkg") %>%
  read_sf(layer = "states")

# convert fold-level trends estimates to sf format


# attach state to the fold-level trends data


# abundance-weighted average trend by region and fold


# summarize across folds for each state

# make a map of the state-level trends
trends_states_sf <- left_join(states, trends_states)
ggplot(trends_states_sf) +
  geom_sf(aes(fill = abd_ppy_median)) +
  scale_fill_distiller(palette = "Reds",
                       limits = c(NA, 0),
                       na.value = "grey80") +
  guides(fill = guide_colorbar(title.position = "top", barwidth = 15)) +
  labs(title = "Trends for sagebrush species 2012-2022",
       fill = "Relative abundance trend [% change / year]") +
  theme_bw() +
  theme(legend.position = "bottom")

# EXERCISE

# applications: multi-species trends ----

# sagebrush species
sagebrush_species <- c("Brewer's Sparrow", "Sagebrush Sparrow", "Sage Thrasher")
trends_runs %>%
  filter(common_name %in% sagebrush_species)

# download data for all species

# load data

# calculate mean trend for each cell

# convert the points to sf format, only cells where all species occur

# make a map
ggplot(all_species) +
  geom_sf(aes(color = abd_ppy), size = 2) +
  scale_color_gradient2(low = "#CB181D", high = "#2171B5",
                        limits = c(-4, 4),
                        oob = scales::oob_squish) +
  guides(color = guide_colorbar(title.position = "left", barheight = 15)) +
  labs(title = "Sage Thrasher state-level trends 2012-2022",
       color = "Relative abundance trend [% change / year]") +
  theme_bw() +
  theme(legend.title = element_text(angle = 90))
