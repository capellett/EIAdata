## Customize the eia data for improved storage . . . Water Planning

library(tidyverse)
library(lubridate)
library(zoo)

rm(list=ls())

eia_utility <- utilities
eia_plant <- plants
eia_generator <- generators
eia_netGen <- net_generation

eia_cooling <- cooling
eia_cooling_detail <- cooling_detail

# eia_utility <- filter(eia_utility, State=='SC')
# eia_plant <- filter(eia_plant, State=='SC')


### Decode prime movers
### Decode energy sources
### Reduce Date Columns
### Reduce fuel columns

library(readxl)

PrimeMovers <- read_xlsx('data-raw\\Code Sheets_2017.xlsx', sheet=2)
EnergySources <- read_xlsx('data-raw\\Code Sheets_2017.xlsx', sheet=1) %>%
  select(`Fuel Type`, `Energy Source Code`, `Energy Source Description`)
EnergySources2 <- select(EnergySources, -`Fuel Type`)

generators <- eia_generator %>%
  join_and_drop(PrimeMovers, by='Prime Mover', rename='Prime Mover') %>%
  join_and_drop(EnergySources, by=c('Energy Source 1'='Energy Source Code'),
                rename=c("PrimaryFuelType", "PrimaryFuel")) %>%
  join_and_drop(EnergySources2, c('Energy Source 2'='Energy Source Code'),'Fuel2') %>%
  join_and_drop(EnergySources2, c('Energy Source 3'='Energy Source Code'),'Fuel3') %>%
  join_and_drop(EnergySources2, c('Energy Source 4'='Energy Source Code'),'Fuel4') %>%
  join_and_drop(EnergySources2, c('Energy Source 5'='Energy Source Code'),'Fuel5') %>%
  join_and_drop(EnergySources2, c('Energy Source 6'='Energy Source Code'),'Fuel6') %>%
  join_and_drop(EnergySources2, c('Startup Source 1'='Energy Source Code'),'Start1') %>%
  join_and_drop(EnergySources2, c('Startup Source 2'='Energy Source Code'),'Start2') %>%
  join_and_drop(EnergySources2, c('Startup Source 3'='Energy Source Code'),'Start3') %>%
  join_and_drop(EnergySources2, c('Startup Source 4'='Energy Source Code'),'Start4') %>%
  monthyear_to_date('Month Uprate or Derate Completed', 'Year Uprate or Derate Completed',
                    'Date Uprate or Derate Completed') %>%
  monthyear_to_date('Operating Month', 'Operating Year', 'Operating Date') %>%
  monthyear_to_date('Planned Retirement Month', 'Planned Retirement Year', 'Retirement') %>%
  monthyear_to_date('Planned Uprate Month', 'Planned Uprate Year', 'Uprate') %>%
  monthyear_to_date('Planned Derate Month', 'Planned Derate Year', 'Derate') %>%
  monthyear_to_date('Planned Repower Month', 'Planned Repower Year', 'Repower') %>%
  monthyear_to_date('Other Modifications Month', 'Other Modifications Year', 'Modifications') %>%
  paste_columns(c('Start1', 'Start2', 'Start3', 'Start4'), 'StartupFuels') %>%
  paste_columns(c('Fuel2', 'Fuel3', 'Fuel4', 'Fuel5', 'Fuel6'), 'SecondaryFuels')


##### Reduce some more columns in eia_generator
## test if modification dates can be gathered into date+type
test <- generators %>%
  mutate(RetDate = is.na(Retirement),
         UpDate = is.na(Uprate),
         DeDate = is.na(Derate),
         ReDate = is.na(Repower),
         OthDate = is.na(Modifications)) %>%
  rowwise() %>%
  mutate(allNA = sum(RetDate, UpDate, DeDate, ReDate, OthDate, na.rm=TRUE)) %>%
  ungroup()

# table(test$allNA)
# filter(test, allNA<4) %>% View()
test[!test$RetDate,'Planned Repower Date'] <- NA

test <- select(test, `Utility ID`, `Plant Code`, `Generator ID`, Year,
               Retirement, Uprate, Derate, Repower, Modifications) %>%
  gather('PlannedAction', 'PlannedDate',
         Retirement:Modifications) %>%
  filter(!is.na(PlannedDate))

# eia_generator <- filter(eia_generator, State=='SC')
generators <- generators %>%
  # filter(State=='SC') %>%
  select(-Retirement, -Uprate, -Derate, -Repower, -Modifications) %>%
  left_join(test) %>%
  filter(Year==2017) %>%
  select(# -State,
    -`RTO/ISO LMP Node Designation`, -Year,
         -`RTO/ISO Location Designation for Reporting Wholesale Sales Data to FERC`,
         -`Uprate or Derate Completed During Year`, -Sector,
         -`Solid Fuel Gasification System?`, -`Carbon Capture Technology?`,
         -`Turbines, Inverters, or Hydrokinetic Buoys`,
         -`Other Combustion Technology?`, -`Ultrasupercritical Technology?`,
         -`Planned Net Summer Capacity Uprate (MW)`, `Planned Net Winter Capacity Uprate (MW)`,
         -`Planned New Prime Mover`, -`Planned Energy Source 1`, -`Planned New Nameplate Capacity (MW)`,
         -`Other Planned Modifications?`, -`Turbines or Hydrokinetic Buoys`) %>%
  rename(UtilityID='Utility ID', Utility='Utility Name', PlantID='Plant Code', Plant='Plant Name',
         Generator='Generator ID', Unit='Unit Code', Sector='Sector Name')

rm(test)

###--- cooling
### Convert number columns to class numeric
### Back calculate diversion volume using gpm and hours in service columns
### If diversion volume is NA, replace with back calculated value
### Remove columns not used in further analysis
cooling <-  eia_cooling %>% monthyear_to_date() %>%
  # semi_join(eia_plant, c('PlantID'='Plant Code')) %>%
  mutate(
    HoursInService = as.numeric(HoursInService),
    IntakeAvgTemp = as.numeric(`IntakeAvgTemp (F)`),
    IntakeMaxTemp = as.numeric(`IntakeMaxTemp`),
    DischargeAvgTemp = as.numeric(`DischargeAvgTemp`),
    DischargeMaxTemp = as.numeric(`DischargeMaxTemp`),
    Chlorine1000lbs = as.numeric(`Chlorine (thousand lbs)`)) %>%
  mutate(
    Diversion=as.numeric(`Diversion (MGal)`),
    Diversion2=as.numeric(`Diversion (gpm)`)*HoursInService*60/1000000,
    Withdrawal=as.numeric(`Withdrawal (MGal)`),
    Withdrawal2=as.numeric(`Withdrawal (gpm)`)*HoursInService*60/1000000,
    Discharge=as.numeric(`Discharge (MGal)`),
    Discharge2=as.numeric(`Discharge (gpm)`)*HoursInService*60/1000000,
    Consumption = as.numeric(`Consumption (MGal)`),
    Consumption2 = as.numeric(`Consumption (gpm)`)*HoursInService*60/1000000) %>%
  mutate(
    Diversion = if_else(is.na(Diversion), Diversion2, Diversion),
    Withdrawal = if_else(is.na(Withdrawal), Withdrawal2, Withdrawal),
    Discharge = if_else(is.na(Discharge), Discharge2, Discharge),
    Consumption = if_else(is.na(Consumption), Consumption2, Consumption) ) %>%
  select(
    -`Chlorine (thousand lbs)`, -`IntakeAvgTemp (F)`,
    -`Diversion (MGal)`, -`Diversion (gpm)`, -Diversion2,
    -`Withdrawal (MGal)`, -`Withdrawal (gpm)`, -Withdrawal2,
    -`Discharge (MGal)`, -`Discharge (gpm)`, -Discharge2,
    -`Consumption (MGal)`, -`Consumption (gpm)`, -Consumption2)


### --- netGen
### select desired columns
### reformat date columns
### decode prime mover

netGen <- eia_netGen %>% # filter(State=='SC') %>%
  select(PlantID, Plant, Sector, OperatorID, Operator, State, GeneratorID,
         PrimeMover, Jan:Dec, Year) %>%
  gather(key="Month", value="MWh", Jan:Dec) %>%
  monthyear_to_date() %>%
  join_and_drop(PrimeMovers, by=c('PrimeMover'='Prime Mover'), rename='Prime Mover')

### --- cooling_detail
### monthyear_to_date()
### Decode Prime Movers and Energy Sources
### join plant and generator data
### select desired columns
cooling_detail <- eia_cooling_detail %>%
  # filter(State=='SC') %>%
  monthyear_to_date() %>%
  monthyear_to_date('Cooling Inservice Month', 'Cooling Inservice Year', 'Cooling Inservice Date') %>%
  monthyear_to_date('Boiler Retirement Month', 'Boiler Retirement Year', 'Boiler Retirement Date') %>%
  monthyear_to_date('Boiler Inservice Month', 'Boiler Inservice Year', 'Boiler Inservice Date') %>%
  monthyear_to_date('Generator Retirement Month', 'Generator Retirement Year', 'Generator Retirement Date') %>%
  monthyear_to_date('Generator Inservice Month', 'Generator Inservice Year', 'Generator Inservice Date') %>%
  join_and_drop(PrimeMovers, c('Generator Prime Mover Code'='Prime Mover'), 'Prime Mover') %>%
  join_and_drop(EnergySources, c('Generator Primary Energy Source Code'='Energy Source Code'),
                c("PrimaryFuelType", "PrimaryFuel")) %>%
  left_join(select(eia_plant, 1:3, Latitude, Longitude, Year)) %>%
  left_join(select(eia_generator, `Plant Code`, `Generator ID`, Year,
                   `Nameplate Capacity (MW)`, `Nameplate Power Factor`,
                   `Summer Capacity (MW)`, `Winter Capacity (MW)`,
                   `Minimum Load (MW)`)) %>%
  select(-X__1, -X__2, # -State,
         -`Number Operable Generators`, -`Number Operable Boilers`, -`Number Operable Cooling Systems`,
         -`Water Type`, -`Water Source`, -`Water Source Name`, -`Water Discharge Name`,
         -`Other Fuel Consumption (MMBTU)`,
         -`Fuel Consumption from Single Shaft Combined Cycle Units (MMBTU)`,
         # -`Net Generation Associated with Single Shaft Combined Cycle Units (MWh)`,
          -`Gross Generation Associated with Single Shaft Combined Cycle Units (MWh)`,
         -`Summer Capacity Associated with Single Shaft Combined Cycle Units (MW)`)


cool <- cooling_detail %>%
  rename(Utility='Utility Name', Plant='Plant Name', PlantID='Plant Code',
         Generator='Generator ID', Boiler='Boiler ID', Cooling='Cooling ID',
         NetSteamGen=`Net Generation from Steam Turbines (MWh)`,
         NetCCGen =
           `Net Generation Associated with Combined Cycle Gas Turbines (MWh)`,
         NetSSCCGen=
           `Net Generation Associated with Single Shaft Combined Cycle Units (MWh)`,
         Withdrawal_MGal='Water Withdrawal Volume (Million Gallons)',
         Consumption_MGal='Water Consumption Volume (Million Gallons)') %>%
  mutate(`gal/kWh`=`Water Consumption Intensity Rate (Gallons / MWh)`/1000,
         NetSteamGen=if_else(is.na(NetSteamGen), 0, NetSteamGen),
         NetCCGen = if_else(is.na(NetCCGen), 0, NetCCGen),
         NetSSCCGen = if_else(is.na(NetSSCCGen), 0, NetSSCCGen)) %>%
  mutate(MWh = NetSteamGen + NetCCGen + NetSSCCGen) %>%
  select(State, Utility, Plant, PlantID, Generator, Boiler, Cooling,
         Date, `gal/kWh`, MWh, NetSteamGen,  NetCCGen, NetSSCCGen,
         Withdrawal_MGal, Consumption_MGal,
         `860 Cooling Type 1`, `860 Cooling Type 2`,
         `923 Cooling Type`, `Cooling System Type`)


length_unique_values <- function(x) length(unique(x, incomparables=NA))
### This should show only a single unique value per cooling system per month.
### Repeated for each generator and boiler ID...
####### This isn't working right...
test <- cool %>%
  group_by(Utility, Plant, Cooling, Date) %>%
  summarise(nWithdrawal = length(unique(Withdrawal_MGal, incomparables=NA)),
            nConsumption = length(unique(Consumption_MGal, incomparables=NA)),
            nMWh=length(unique(MWh, incomparables=NA)),
            nBoiler=length(unique(Boiler, incomparables=NA)),
            nGenerator=length(unique(Generator, incomparables=NA)),
            nSteam=length(unique(round(NetSteamGen), incomparables=NA)),
            nCC=length(unique(round(NetCCGen), incomparables=NA)),
            nSSCC=length(unique(round(NetSSCCGen), incomparables=NA)),
            `860 Cooling Type 1`=length(unique(`860 Cooling Type 1`, incomparables=NA)),
            `860 Cooling Type 2`=length(unique(`860 Cooling Type 2`, incomparables=NA)),
            `923 Cooling Type` = length(unique(`923 Cooling Type`, incomparables=NA)),
            `Cooling System Type`=length(unique(`Cooling System Type`, incomparables=NA))
  )

### This probably won't work until the test looks right.
coolers <- cool %>%
  group_by(State, Utility, Plant, PlantID, Cooling, Date) %>%
    summarise(
      Generators = paste0(unique(Generator), collapse=', '),
      Boilers = paste0(unique(Boiler), collapse=', '),
      Withdrawal_MGal = unique(Withdrawal_MGal),
      Consumption_MGal = unique(Consumption_MGal),
      MWh=sum(MWh, na.rm=TRUE),
      `860 Cooling Type 1`=unique(`860 Cooling Type 1`),
      `860 Cooling Type 2`=unique(`860 Cooling Type 2`),
      `923 Cooling Type` = unique(`923 Cooling Type`),
      `Cooling System Type`=unique(`Cooling System Type`) )


cool_joins <- cool %>%
  select(Utility, PlantID, Generator, Cooling) %>%
  unique()

# nrow(unique(eia_netGen2[c(1,4)])) # 29 plants
# nrow(unique(eia_netGen2[c(1,4,6)])) # 72 generators
#
# nrow(unique(cooling_joins_SC[c(1:2)])) # 20 plants
# nrow(unique(cooling_joins_SC[1:3])) # 53 generators
# nrow(unique(cooling_joins_SC[c(1:2, 4)])) # 42 cooling systems
# nrow(unique(cooling_joins_SC[1:4])) # 65 joins

## Join cool and eia_cooling2 and eia_netGen2 in to a single table?


## For each plant,
## plot generators and cooling systems, colored by cooling system.

### Title: Utility, Plant, Cooling System
### graph 1: Withdrawal and Consumption over time.
### graph 2: MWh, total NamePlate capacity, and capacity*power factor over time
### graph 3: gal/kWh over time
### graph 4: Fuel Consumption per Gen:Boil:Cool over time, facet by fuel type

### Table of generators
### Table of boilers
### Table of coolers
### Linked graph of boilers, generators, and coolers?

#### Compare graph 1 with water use database
#### y axis title = Million Gallons per Month
#### Combine eia_cooling with cooling_detail

# cool_SC <- filter(cool, State=='SC')

coolers_SC <- filter(coolers, State=='SC') %>% ungroup()

plot_eia_coolers <- function(plantID, cooling) {
  cool1 <- filter(coolers_SC, PlantID==plantID & Cooling==cooling)
  cooling2 <- unique(cool1$Cooling)
  utility <- unique(cool1$Utility)
  plant <- unique(cool1$Plant)
  boilerIDs <- unique(cool1$Boilers)
  generatorIDs <- unique(cool1$Generators)
  title <- paste0(utility, ':', plant, ', Cooling System:', cooling2)
  subtitle <- paste0('Boilers: ', boilerIDs, '. Generators: ', generatorIDs)

  graph1 <- ggplot(cool1, aes(x=Date)) +
    geom_line(aes(y=Withdrawal_MGal), color = 'blue') +
    geom_line(aes(y=Consumption_MGal), color='red') +
    ggtitle(title, subtitle)

  print(graph1)

  ### graph 2: MWh, total NamePlate capacity, and capacity*power factor over time
  gen <- semi_join(generators, cool1,
                   by=c('State', 'PlantID')) %>%
    select(Generator, `Nameplate Capacity (MW)`,
           `Nameplate Power Factor`, `Summer Capacity (MW)`,
           `Winter Capacity (MW)`, `Minimum Load (MW)`, Status,
           PlannedAction, PlannedDate) %>%
    mutate(Capacity = `Nameplate Capacity (MW)`*`Nameplate Power Factor`)
  print(gen)
  # graph2 <- ggplot()

  graph3 <- ggplot(cool1, aes(x=Date)) +
    geom_line(aes(y=Consumption_MGal*1000/(MWh))) +
    ylab('Consumption Rate (gal/kWh)')

  print(graph3)
}

for(i in 1:nrow(unique(coolers_SC[,c('PlantID', 'Cooling')]))) {
  j <- unique(coolers_SC[,c('PlantID', 'Cooling')])[i,]

  plot_eia_coolers(j$PlantID, j$Cooling)}





## gallons_per_kWh_2017
eia <- eia_netGen2 %>%
  # filter(eia_netGen2, Date > as_date('2017-01-01')) %>%
  left_join(cooling_joins_SC, by=c('OperatorID'='UtilityID', 'PlantID', 'GeneratorID')) %>%
  left_join(eia_cooling3) %>%
  mutate(`gal/kWh` = `Consumption (gal)`/(as.numeric(MWh)*1000)) %>%


  # x <- gallons_per_kWh_2017 %>%
  #   select(Operator, Plant, PrimeMover, `Cooling System Type`, CoolingID, GeneratorID) %>%
  #   unique() %>%
  #   left_join(PrimeMovers, c('PrimeMover'='Prime Mover')) %>%
  #   select(-PrimeMover) %>%
  #   rename(PrimeMover = `Prime Mover Description`)

  # y <- gallons_per_MWh_2017 %>%
  #   group_by(Operator, Plant, PrimeMover, CoolingID, GeneratorID) %>%
#   summarise(`gal/kWh` = median(`gal/kWh`, na.rm=T))

# z <- left_join(x,y)

# netGen_summary <- netGen_SC %>%
#   filter(Date > as_date('2017-01-01')) %>%
#   left_join(PrimeMovers, c('PrimeMover'='Prime Mover')) %>%
#   select(-PrimeMover) %>%
#   rename(PrimeMover = `Prime Mover Description`) %>%
#   group_by(Operator, Plant, PlantID) %>%
#   summarise(Generators = length(unique(GeneratorID)),
#             PrimeMovers = paste(unique(PrimeMover), collapse=' '),
#             MWh = sum(as.numeric(MWh), na.rm=T))

cooling_SC2 <- left_join(
  cooling_SC,
  {
    group_by(cooling_joins_SC, PlantID, CoolingID) %>%
      summarise(`Cooling System Type` = paste(unique(`Cooling System Type`), collapse=', '))
  })

cooling_summary <- cooling_SC2 %>%
  filter(Date > as_date('2017-01-01')) %>%
  group_by(PlantID) %>%
  summarise(`Consumption (gal)` = sum(`Consumption (gal)`, na.rm=T),
            `Cooling System Type` = paste(unique(`Cooling System Type`), collapse=', '))

generator_summary <- eia_generator %>%
  filter(Year==2017) %>%
  group_by(`Plant Code`) %>%
  summarise(`Nameplate Capacity (MW)`=sum(`Nameplate Capacity (MW)`, na.rm=T),
            Fuel=paste(unique(`Energy Source 1`), collapse=', '))

summary <- left_join(netGen_summary, cooling_summary) %>%
  mutate(`gal/kWh`=`Consumption (gal)` / (MWh*1000),
         `Average Output (MW)`=MWh/(365*24)) %>%
  left_join(generator_summary, c('PlantID'='Plant Code')) %>%
  select(Operator, Plant, Fuel, `Prime Mover`=PrimeMovers,
         `Cooling System`=`Cooling System Type`, Generators,
         `Nameplate Capacity (MW)`, `Average Output (MW)`,
         `Consumption Factor (gal/kWh)`=`gal/kWh`) %>%
  ungroup()

write.csv(summary, 'Energy Information Administration\\Thermoelectric 2016 Summary.csv')

### Summaries for SC
# eia_generator %>%
#   group_by(`Prime Mover`, Year) %>%
#   summarise(`Nameplate Capacity (MW)`=sum(`Nameplate Capacity (MW)`, na.rm=T)) %>%
#   spread(Year, `Nameplate Capacity (MW)`) %>%
#   write.csv('Energy Information Administration\\Capacity by Prime Mover.csv')
#
# eia_generator %>%
#   group_by(`Energy Source 1`, Year) %>%
#   summarise(`Nameplate Capacity (MW)`=sum(`Nameplate Capacity (MW)`, na.rm=T)) %>%
#   spread(Year, `Nameplate Capacity (MW)`) %>%
#   write.csv('Energy Information Administration\\Capacity by Energy Source.csv')
#
# eia_generator %>%
#   group_by(`Primary Fuel Type`, `Prime Mover`, Year) %>%
#   summarise(`Nameplate Capacity (MW)`=sum(`Nameplate Capacity (MW)`, na.rm=T)) %>%
#   spread(Year, `Nameplate Capacity (MW)`) %>%
#   arrange(desc(`2016`)) %>%
#   write.csv('Energy Information Administration\\Capacity by Prime Mover and Fuel Type.csv')


