library(readxl)


#****************************************************************************************#
#                    Functions used in the script                                        #
#****************************************************************************************#

# Rename columns that are numeric years and remove parentheses
fn_handle_colnames <- function(dat){
  colnames(dat) <- sapply(colnames(dat), function(x) {
    # Remove parentheses
    x <- gsub("[()]", "", x)

    # Rename numeric years
    if (grepl("^[0-9]{4}\\.{0,1}[0-9]*$", x)) {
      return(paste0("Y", substr(x, 1, 4)))
    } else {
      return(x)
    }
  })
  return(dat)
}

# Apply the rounding function to each numeric column
fn_round_numeric <- function(dat){

  modified_dat <- as.data.frame(lapply(dat, function(x) {
    if(is.numeric(x)) round(x, 2) else x
  }))

  return (modified_dat)

}

fn_last_colname <- function(dat) {
  colnames(dat)[ncol(dat)] <- "AGR"
  return (dat)
}

#****************************************************************************************#
#                                   2019 data                                            #
#****************************************************************************************#

# Read the data, including the fourth row
AEO2019_dat <- read_excel("data-raw/macroeconomic/year2019_Industrial_Sector_Macroeconomic_Indicators.xls", skip = 3)

# Set the fourth row as column names
colnames(AEO2019_dat) <- as.character(AEO2019_dat[1, ])

# Remove the fourth row from the data
AEO2019_dat <- AEO2019_dat[-1, ]


AEO2019_dat <- fn_handle_colnames(AEO2019_dat)


AEO2019_dat <- AEO2019_dat[,-c(3,4,5)]

# Convert columns from the 3rd to the last to numeric
AEO2019_dat[, 3:ncol(AEO2019_dat)] <- lapply(AEO2019_dat[, 3:ncol(AEO2019_dat)], as.numeric)


AEO2019_dat <- fn_round_numeric(AEO2019_dat)



#****************************************************************************************#
#                                   2020 data                                            #
#****************************************************************************************#

# Read the data, including the fourth row
AEO2020_dat <- read_excel("data-raw/macroeconomic/year2020_AEO 2020 suptab_23.xlsx")

AEO2020_dat <- fn_handle_colnames(AEO2020_dat)


# Convert columns from the 3rd to the last to numeric
AEO2020_dat[, 3:ncol(AEO2020_dat)] <- lapply(AEO2020_dat[, 3:ncol(AEO2020_dat)], as.numeric)

# Apply the rounding function to each numeric column
AEO2020_dat <- fn_round_numeric(AEO2020_dat)

#****************************************************************************************#
#                                   2021 data                                            #
#****************************************************************************************#

# Read the data, including the fourth row
AEO2021_dat <- read_excel("data-raw/macroeconomic/year2021_Table_23_Industrial_Sector_Macroeconomic_Indicators.xlsx")

AEO2021_dat <- fn_handle_colnames(AEO2021_dat)

AEO2021_dat <- AEO2021_dat[,-c(3)]

# Convert columns from the 3rd to the last to numeric
AEO2021_dat[, 3:ncol(AEO2021_dat)] <- lapply(AEO2021_dat[, 3:ncol(AEO2021_dat)], as.numeric)

# Apply the rounding function to each numeric column
AEO2021_dat <- fn_round_numeric(AEO2021_dat)

AEO2021_dat$Type <- paste0(AEO2021_dat$Type, " Sector")
#****************************************************************************************#
#                                   2023 data                                            #
#****************************************************************************************#

# Read the data, including the fourth row
AEO2023_dat <- read_excel("data-raw/macroeconomic/year2023_Table_23._Industrial_Sector_Macroeconomic_Indicators.xlsx")

removed_cols <- AEO2023_dat[c(1,2,38),]

AEO2023_dat <- AEO2023_dat[-c(1,2,38),]

AEO2023_dat <- fn_handle_colnames(AEO2023_dat)

AEO2023_dat <- AEO2023_dat[,-c(3)]

# Convert columns from the 3rd to the last to numeric
AEO2023_dat[, 3:ncol(AEO2023_dat)] <- lapply(AEO2023_dat[, 3:ncol(AEO2023_dat)], as.numeric)

# Apply the rounding function to each numeric column
AEO2023_dat <- fn_round_numeric(AEO2023_dat)


#****************************************************************************************#
#                                   Final data                                           #
#****************************************************************************************#

# Objects to keep
keep_objects <- c("AEO2019_dat", "AEO2020_dat", "AEO2021_dat", "AEO2023_dat")

for (df_name in keep_objects) {

  # Retrieve the dataframe, apply the function, and update it in the environment
  updated_df <- fn_last_colname(get(df_name))

  assign(df_name, updated_df)

}


# List of all objects in the environment
all_objects <- ls()

# Remove all objects except for 'AEO2019_dat' and 'AEO2020_dat'
rm(list = setdiff(all_objects, keep_objects))


usethis::use_data(AEO2019_dat, overwrite=T)
usethis::use_data(AEO2020_dat, overwrite=T)
usethis::use_data(AEO2021_dat, overwrite=T)
usethis::use_data(AEO2023_dat, overwrite=T)



#****************************************************************************************#
#                                   Analyse data                                         #
#****************************************************************************************#
rm(list = ls())
load("data/AEO2019_dat.rda")
load("data/AEO2020_dat.rda")
load("data/AEO2021_dat.rda")
load("data/AEO2023_dat.rda")

# AEO2020_dat$Type <- trimws(AEO2020_dat$Type)
# AEO2021_dat$Type <- trimws(AEO2021_dat$Type)
# AEO2023_dat$Type <- trimws(AEO2023_dat$Type)


library(tidyverse)

data <- AEO2020_dat
fn_transform <- function(data) {

   data_long <- data %>%
    gather(key = "Year", value = "WaterDemand", starts_with("Y")) %>%
    mutate(Year = as.numeric(sub("Y", "", Year))) # Convert Year to numeric

  return(data_long)
}

# Load and transform each dataset
data_2020 <- fn_transform(AEO2020_dat)
data_2021 <- fn_transform(AEO2021_dat)
data_2023 <- fn_transform(AEO2023_dat)

# Merging the datasets
merged_data <- reduce(list(data_2020, data_2021, data_2023), full_join, by = c("Year", "Type", "Sector"))

merged_data <- merged_data %>%
# Rename the columns for clarity
names(merged_data)[names(merged_data) == "WaterDemand.x"] <- "WaterDemand_2020"
names(merged_data)[names(merged_data) == "WaterDemand.y"] <- "WaterDemand_2021"
names(merged_data)[names(merged_data) == "WaterDemand"] <- "WaterDemand_2023"

# Plotting
plot_data <- function(data, type, sector) {
  filtered_data <- data %>%
    filter(Type == type, Sector == sector)

  ggplot(filtered_data, aes(x = Year)) +
    geom_line(aes(y = WaterDemand_2020, colour = "2020 Data")) +
    geom_line(aes(y = WaterDemand_2021, colour = "2021 Data")) +
    geom_line(aes(y = WaterDemand_2023, colour = "2023 Data")) +
    labs(title = paste("Water Demand Projection for", type, "-", sector),
         x = "Year",
         y = "Water Demand") +
    theme_minimal() +
    scale_colour_manual(values = c("2020 Data" = "blue", "2021 Data" = "green", "2023 Data" = "red"))
}

# Example plot for a specific type and sector
plot_data(merged_data, "Type_Example", "Sector_Example")

