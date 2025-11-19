## Nov 2025
## check out JHU covid dataset

## example: plots for Washtenaw county, Michigan

data_directory = "../JHU-Covid/" # specify data folder path

# Load required libraries
library(tidyverse)
library(lubridate)

# Read the CSV files
cases <- readr::read_csv(file.path(data_directory, "time_series_covid19_confirmed_US.csv"))
deaths <- readr::read_csv(file.path(data_directory, "time_series_covid19_deaths_US.csv"))

# Filter for Washtenaw County, Michigan
cases_washtenaw <- cases %>%
  filter(Admin2 == "Washtenaw", Province_State == "Michigan")

deaths_washtenaw <- deaths %>%
  filter(Admin2 == "Washtenaw", Province_State == "Michigan")

# Extract date columns (columns 13 onward)
date_cols <- 13:ncol(cases_washtenaw)

# Get the date column names and convert to proper dates
date_names <- colnames(cases_washtenaw)[date_cols]
dates <- mdy(date_names)

# Extract the count data for Washtenaw County
case_counts <- as.numeric(cases_washtenaw[1, date_cols])
death_counts <- as.numeric(deaths_washtenaw[1, date_cols])

# Create a data frame for plotting
df <- data.frame(
  date = dates,
  cases = case_counts,
  deaths = death_counts
)

# Create the plot with two panels
p1 <- ggplot(df, aes(x = date, y = cases)) +
  geom_line(color = "#2E86AB", linewidth = 1) +
  labs(
    title = "Cumulative Cases",
    x = "Date",
    y = "Case Count"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

p2 <- ggplot(df, aes(x = date, y = deaths)) +
  geom_line(color = "#A23B72", linewidth = 1) +
  labs(
    title = "Cumulative Deaths",
    x = "Date",
    y = "Death Count"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

# Combine plots side by side
library(patchwork)
p1 + p2 +
  plot_annotation(
    caption = "COVID-19 in Washtenaw County, Michigan",
    theme = theme(plot.caption = element_text(hjust = 1, face = "bold", size = 14))
  )

