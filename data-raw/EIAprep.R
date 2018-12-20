## This script will read in data from EIA forms 860 and 923
## To run it, you need to download the forms and unzip them...

library(readxl)
library(tidyverse)
library(lubridate)
library(zoo)
############# FORM 860
## 2001 - 2003 : in .dbf format

## 2004
## UtilY04 have PlantY04 which have GenY04
## MFExist04 has info regarding multi-fuel plants
## PRGenY04 has info regarding proposed plants
## MFProp04 has info regarding proposed multi-fuel plants
## PCGenY04 has info regarding proposed changes to existing plants
## OwnerY04 has info regarding generators that are owned by someone other than the operator.
## Layout describes the other workbooks. 
## Each workbook aside from Layout is a single worksheet.

## 2005 - 2006 : same files as 2004, plus Intcon05, which has data on new interconnection costs.

## 2007 - 2008 : doesn't have PCGen
## does have F860_Schedule6 with a bunch of sheets on the boilers
## and another book to explain the F860_Schedule6 sheets.

## 2009 - 2012 : different names from previous.
## apparently broke up the Schedule6 sheets into two Enviro sheets.

## 2013 - 2017 : different file names from previous.
## generator file is multi-sheet. 'Operable', 'Proposed', 'Retired and Cancelled'
## I only need 'Operable'
## includes wind and solar workbooks.

## TODO: for the most recent year, look at the worksheet named 'Proposed'.

for(i in 2013:2017) {
  folder <- paste0('Energy Information Administration\\form 860\\eia860', i, '\\')
  
  utility <- read_xlsx(paste0(folder, '1___Utility_Y', i,'.xlsx'), 
                       sheet=1, skip=1)
  utility$Year <- i
  assign(paste0('utility', i), utility)
  
  plant <- read_xlsx(paste0(folder, '2___Plant_Y', i, '.xlsx'), 
                     sheet=1, skip=1, guess_max=5000)
  plant$Year <- i
  assign(paste0('plant', i), plant)
  
  generator <- read_xlsx(paste0(folder, '3_1_Generator_Y', i, '.xlsx'), 
                         sheet=1, skip=1, guess_max=10000)
  generator$Year <- i
  assign(paste0('generator', i), generator)
  
  rm(utility, plant, generator, folder, i)
}

names(utility2013) <- names(utility2016)
names(utility2014) <- names(utility2016)
names(utility2015) <- names(utility2016)
utility2017 <- select(utility2017, -Caution)
utility <- bind_rows(utility2013, utility2014, utility2015, utility2016, utility2017)
rm(utility2013, utility2014, utility2015, utility2016, utility2017)

plant2017 <- select(plant2017, -Caution)
plant <- bind_rows(plant2013, plant2014, plant2015, plant2016, plant2017)
rm(plant2013, plant2014, plant2015, plant2016, plant2017)

generator2017 <- select(generator2017, -Caution)
generator <- bind_rows(generator2013, generator2014, 
                           generator2015, generator2016, generator2017)
rm(generator2013, generator2014, generator2015, generator2016, generator2017)

# for(i in 2013:2016) {
#   folder <- paste0('form 860\\eia860', i, '\\')
#   
#   EnviroAssoc <- read_xlsx(paste0(folder, '6_1_EnviroAssoc_Y', i,'.xlsx'), 
#                        sheet=1, skip=1)
#   EnviroAssoc$Year <- i
#   assign(paste0('EnviroAssoc', i), EnviroAssoc)
#   
#   EnviroEquip <- read_xlsx(paste0(folder, '6_2_EnviroEquip_Y', i, '.xlsx'), 
#                      sheet=1, skip=1)
#   EnviroEquip$Year <- i
#   assign(paste0('EnviroEquip', i), EnviroEquip)
#   
#   rm(EnviroAssoc, EnviroEquip, folder, i)
# }
# 
# EnviroAssoc2013_2016 <- bind_rows(
#   EnviroAssoc2013, EnviroAssoc2014, EnviroAssoc2015, EnviroAssoc2016)
# rm(EnviroAssoc2013, EnviroAssoc2014, EnviroAssoc2015, EnviroAssoc2016)
# 
# EnviroEquip2013_2016 <- bind_rows(
#   EnviroEquip2013, EnviroEquip2014, EnviroEquip2015, EnviroEquip2016)
# rm(EnviroEquip2013, EnviroEquip2014, EnviroEquip2015, EnviroEquip2016)


######### form 923.
## It has a lot of pages/'schedules'/sheets in the yearly workbooks
## I compiled the two sheets I thought were relevant from each year into two workbooks.
## (manually). So, could be good to write a function to read in all the sheets...
for(i in  2012:2017) {
  netGen <- read_xlsx(
    'Energy Information Administration\\f923_Page4_Generators.xlsx', 
    sheet=as.character(i), skip=5, guess_max=10000)
  names(netGen) <- c(
    'PlantID', 'Combined Heat and Power', 'Plant', 'Operator', 'OperatorID',
    'State', 'CensusRegion', 'NERCRegion', 'NAICS', 'SectorNumber', 'Sector', 
    'GeneratorID', 'PrimeMover', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'YearToDate', 'Year')
  assign(paste0('netGen', i), netGen)

  cooling <- read_xlsx(
    'Energy Information Administration\\f923_Schedule8_Cooling.xlsx', 
    sheet=as.character(i), skip=4, guess_max=10000)
  names(cooling) <- c(
    'Year', 'Month', 'PlantID', 'CoolingID', 'CoolingType', 'CoolingStatus', 'HoursInService',
    'Chlorine (thousand lbs)', 'Diversion (gpm)', 'Withdrawal (gpm)', 'Discharge (gpm)', 
    'Consumption (gpm)', 'FlowMethod', 'IntakeAvgTemp (F)', 'IntakeMaxTemp', 'DischargeAvgTemp', 
    'DischargeMaxTemp', 'TempMethod', 'Diversion (MGal)', 'Withdrawal (MGal)', 'Discharge (MGal)', 
    'Consumption (MGal)')
  assign(paste0('cooling', i), cooling)
  
  rm(netGen, cooling, i)
}

## f923_Schedule8_Cooling
## I'm not sure I need this, use cooling_detail instead ?
cooling <- bind_rows(cooling2012, cooling2013, cooling2014,
                     cooling2015, cooling2016, cooling2017)
rm(cooling2012, cooling2013, cooling2014,
   cooling2015, cooling2016, cooling2017)


### f923_Page4_Generators 
netGen <- bind_rows(netGen2012, netGen2013, netGen2014,
                    netGen2015, netGen2016, netGen2017)
rm(netGen2012, netGen2013, netGen2014,
   netGen2015, netGen2016, netGen2017)


###### COOLING DETAIL
## I downloaded these sheets from https://www.eia.gov/electricity/data/water/
## and compiled them in to a single workbook (it is too big, probably should have kept them separate)
## and deleted some whitespace in the title of the first column heading ('Utility ID')
## and deleted two blank rows at the top.
cj14 <- read_xlsx('Energy Information Administration\\cooling_detail.xlsx',
                  sheet='2014', guess_max=10000) %>%
  mutate(`Steam Plant Type`=as.numeric(`Steam Plant Type`))

cj15 <- read_xlsx('Energy Information Administration\\cooling_detail.xlsx',
                  sheet='2015', guess_max=10000) %>%
  mutate(`Other Gas Consumption (MMBTU)` = as.numeric(`Other Gas Consumption (MMBTU)`),
         `Steam Plant Type`=as.numeric(`Steam Plant Type`))

cj16 <- read_xlsx('Energy Information Administration\\cooling_detail.xlsx',
                  sheet='2016', guess_max=10000) %>%
  mutate(`Other Gas Consumption (MMBTU)` = as.numeric(`Other Gas Consumption (MMBTU)`),
         `Steam Plant Type`=as.numeric(`Steam Plant Type`))

cj17 <- read_xlsx('Energy Information Administration\\cooling_detail_2017.xlsx', 
                           skip=2, guess_max=10000) %>%
  mutate(Year=as.numeric(Year), Month=as.numeric(Month))

cooling_detail <- bind_rows(cj17, cj16, cj15, cj14)
rm(cj14, cj15, cj16, cj17)


usethis::use_data(generator)
usethis::use_data(plant)
usethis::use_data(utility)
usethis::use_data(cooling)
usethis::use_data(netGen)
usethis::use_data(cooling_detail)

# generator <- readRDS('Energy Information Administration\\eia_generator_2013-2017.rds')
# plant <- readRDS('Energy Information Administration\\eia_plant_2013-2017.rds')
# utility <- readRDS('Energy Information Administration\\eia_utility_2013-2017.rds')
# cooling <- readRDS('Energy Information Administration\\eia_cooling_2012-2017.rds')
# netGen <- readRDS('Energy Information Administration\\eia_netGen_2012-2017.rds')
# cooling_detail <- readRDS('Energy Information Administration\\cooling_detail.rds')
# 

