library(readxl)
library(ggplot2)
library(tidyr)


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

# Replace AEO2021_dat$Sector with AEO2021_dat$Subsector if it's non-NA, otherwise keep AEO2021_dat$Sector. This has to be added for 2021 and 2023
AEO2021_dat$Sector <- ifelse(!is.na(AEO2021_dat$Subsector), AEO2021_dat$Subsector, AEO2021_dat$Sector)

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
# Replace AEO2021_dat$Sector with AEO2021_dat$Subsector if it's non-NA, otherwise keep AEO2021_dat$Sector
AEO2023_dat$Sector <- ifelse(!is.na(AEO2023_dat$Subsector), AEO2023_dat$Subsector, AEO2023_dat$Sector)

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



#****************************************************************************************#
#                                   Check the data reporting                             #
#****************************************************************************************#

fn_check_reporting <- function(dat1,dat2,dat3){

# Extracting unique sectors
unique_sectors_2020 <- unique(dat1$Sector)
unique_sectors_2021 <- unique(dat2$Sector)
unique_sectors_2023 <- unique(dat3$Sector)

# Creating a master list of all unique sectors
all_sectors <- unique(c(unique_sectors_2020, unique_sectors_2021, unique_sectors_2023))

# Initializing the final data frame
sector_comparison <- data.frame(Sector = all_sectors,
                                In_2020 = "No",
                                In_2021 = "No",
                                In_2023 = "No")

# Checking presence of each sector in each year
sector_comparison$In_2020[sector_comparison$Sector %in% unique_sectors_2020] <- "Yes"
sector_comparison$In_2021[sector_comparison$Sector %in% unique_sectors_2021] <- "Yes"
sector_comparison$In_2023[sector_comparison$Sector %in% unique_sectors_2023] <- "Yes"


#****************************************************************************************#
#                                   Plot                                                 #
#****************************************************************************************#

sector_comp_plot <- gather(sector_comparison, key = "Year", value = "Reported", In_2020, In_2021, In_2023)

# Adjusting Year values for x-axis labels
sector_comp_plot$Year <- as.factor(sector_comp_plot$Year)
levels(sector_comp_plot$Year) <- c("2020", "2021", "2023")  # Rename levels to display correct years

# Choosing colorblind-friendly colors
color_blind_friendly_colors <- c("Yes" = "#377eb8", "No" = "#e41a1c")  # Blue and Reddish

# Plotting a bar chart with sectors on the y-axis and years on the x-axis
p <- ggplot(sector_comp_plot, aes(x = Sector, fill = Reported)) +
  geom_bar(position = "dodge") +
  facet_wrap(~Year) +
  scale_fill_manual(values = c("Yes" = "#377eb8", "No" = "red")) +
  theme_minimal() +
  theme(axis.text.x = element_blank(),
        axis.title.x= element_blank()) +
  labs(title = "Sector Reporting Across Years", x = "Sector", y = "Count") +

  coord_flip()


p

return(p)
}


fn_check_reporting (AEO2020_dat,AEO2021_dat,AEO2023_dat)
#******************************************************************************************************************#
# From visualization, Sector Stone, Clay and Glass  Products was reported as Sector Stone, Clay and Glass in 2021  #
#******************************************************************************************************************#

AEO2021_dat$Sector[AEO2021_dat$Sector == "Stone, Clay, and Glass"] <- "Stone, Clay, and Glass Products"

fn_check_reporting (AEO2020_dat,AEO2021_dat,AEO2023_dat)


usethis::use_data(AEO2019_dat, overwrite=T)
usethis::use_data(AEO2020_dat, overwrite=T)
usethis::use_data(AEO2021_dat, overwrite=T)
usethis::use_data(AEO2023_dat, overwrite=T)



#****************************************************************************************#
#                                   Analyse data
# For this part. Let's remove the data that is not reported in the later years.          #
#****************************************************************************************#
rm(list = ls())
load("data/AEO2019_dat.rda")
load("data/AEO2020_dat.rda")
load("data/AEO2021_dat.rda")
load("data/AEO2023_dat.rda")

library(tidyverse)


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

# Starting year is adjusted to 2022 to have values from all projections

merged_data <- merged_data %>%
  filter(Year >= 2022)


has_na_rows <- any(rowSums(is.na(merged_data)) > 0)
#FALSE


merged_data <- merged_data %>%
  rename(
    WaterDemand_2020 = WaterDemand.x,
    WaterDemand_2021 = WaterDemand.y,
    WaterDemand_2023 = WaterDemand,
    AGR_2020 = AGR.x,
    AGR_2021 = AGR.y,
    AGR_2023 = AGR
  )

All_sectors <- unique(merged_data$Sector)





fn_plot_dat <- function(data){

  p_sector <- merged_data %>%
    filter(Sector == data)


max_water_demand <- max(c(
  max(p_sector$WaterDemand_2020),
  max(p_sector$WaterDemand_2021),
  max(p_sector$WaterDemand_2023)
))

if (max_water_demand < 200) {
    p_limit = 200
  p_break = 25
}else{
  p_limit = max_water_demand+100
  p_break = 100
}

p <- ggplot(p_sector, aes(x = Year)) +
  geom_line(aes(y = WaterDemand_2020, color = "WaterDemand_2020"), size = 1) +
  geom_line(aes(y = WaterDemand_2021, color = "WaterDemand_2021"), size = 1) +
  geom_line(aes(y = WaterDemand_2023, color = "WaterDemand_2023"), size = 1) +
  labs(
    title = paste0("AEO outlook: ", All_sectors[i]),
    x = "Year",
    y = "$ (Outlook)",
    color = "Legend"
  ) +
  scale_x_continuous(
    breaks = seq(min(p_sector$Year), max(p_sector$Year), by = 2),
    limits = c(min(p_sector$Year), max(p_sector$Year))
  ) +
  scale_y_continuous(
    breaks = seq(0, p_limit, by = p_break),
    limits = c(0, p_limit)
  )  +
  scale_color_manual(
    name = "Legend",
    values = c("WaterDemand_2020" = "#377eb8", "WaterDemand_2021" = "#984ea3", "WaterDemand_2023" = "#ff7f00"),
    labels = c("2020 data", "2021 data", "2023 data")
  ) +
  theme_bw()+
  theme(
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 12),
    plot.title = element_text(size = 16),
    legend.text = element_text(size = 12),
    legend.title = element_blank()
  )
p


# Replace "/" with "_" in All_sectors[i]
All_sectors[i] <- gsub("/", "_", All_sectors[i])

# Construct the file path with the corrected All_sectors[i]
file_path <- paste0("data-raw/macroeconomic/plot/", All_sectors[i], ".png")

# Save the ggplot as a PNG file with the corrected file path
ggsave(file_path, plot = p, width = 8, height = 6, dpi = 300)
}

for (i in 1:length(All_sectors)) {
  fn_plot_dat(All_sectors[i])
}

