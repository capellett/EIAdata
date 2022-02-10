# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

#' Utilities
#'
#' Annual entries for electric utility information from EIA form 860 over the years 2013-2020.
#'
#' @format A data frame with twelve variables:
#' \describe{
#' \item{\code{Utility ID}}{an integer value that identifies each utility}
#' \item{\code{Utility Name}}{the name of the utility}
#' \item{\code{Street Address}}{}
#' \item{\code{City}}{}
#' \item{\code{State}}{}
#' \item{\code{Zip}}{}
#' \item{\code{Owner of Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Entity Type}}{}
#' \item{\code{Year}}{Year}
#' }
#' For further details, see \url{http://www.ssa.gov/oact/NOTES/as120/LifeTables_Body.html#wp1168594}
#'
"utilities"

#' Plants
#'
#' Annual entries for electric power generation plants in EIA form 860 over the years 2013-2020.
#'
#' @format A data frame with 45 variables:
#' \describe{
#' \item{\code{Utility ID}, \code{Utility Name}}{Unique identification codes and names of the electricity utilities.}
#' \item{\code{Plant Code}, \code{Plant Name}}{Numeric codes and names of the power plants.}
#' \item{\code{Street Address}, \code{City}, \code{State}, \code{Zip},
#'     \code{County}, \code{Latitude}, \code{Longitude}}{Location of each plant.}
#' \item{\code{NERC Region}}{desc}
#' \item{\code{Balancing Authority Code}}{desc}
#' \item{\code{Balancing Authority Name}}{desc}
#' \item{\code{Name of Water Source}}{desc}
#' \item{\code{Primary Purpose (NAICS Code)}}{desc}
#' \item{\code{Regulatory Status}}{desc}
#' \item{\code{Sector}}{desc}
#' \item{\code{Sector Name}}{desc}
#' \item{\code{Net Metering (for facilities with solar and wind generation)}}{desc}
#' \item{\code{FERC Cogeneration Status}}{desc}
#' \item{\code{FERC Cogeneration Docket Number}}{desc}
#' \item{\code{FERC Small Power Producer Status}}{desc}
#' \item{\code{FERC Small Power Producer Docket Number}}{desc}
#' \item{\code{FERC Exempt Wholesale Generator Status}}{desc}
#' \item{\code{FERC Exempt Wholesale Generator Docket Number}}{desc}
#' \item{\code{Ash Impoundment?}}{desc}
#' \item{\code{Ash Impoundment Lined?}}{desc}
#' \item{\code{Ash Impoundment Status}}{desc}
#' \item{\code{Transmission or Distribution System Owner}}{desc}
#' \item{\code{Transmission or Distribution System Owner ID}}{desc}
#' \item{\code{Transmission or Distribution System Owner State}}{desc}
#' \item{\code{Grid Voltage (kV)}}{desc}
#' \item{\code{Grid Voltage 2 (kV)}}{desc}
#' \item{\code{Grid Voltage 3 (kV)}}{desc}
#' \item{\code{Natural Gas Pipeline Name}}{desc}
#' \item{\code{Year}}{desc}
#' \item{\code{Energy Storage}}{desc}
#' \item{\code{Natural Gas LDC Name}}{desc}
#' \item{\code{Natural Gas Pipeline Name 1}}{desc}
#' \item{\code{Natural Gas Pipeline Name 2}}{desc}
#' \item{\code{Natural Gas Pipeline Name 3}}{desc}
#' \item{\code{Pipeline Notes}}{desc}
#' \item{\code{Natural Gas Storage}}{desc}
#' \item{\code{Liquified Natural Gas Storage}}{desc}
#' }
#'
"plants"

#' Generators
#'
#' Annual entries for each electric power generators in EIA form 860 over the years 2013-2020
#'
#' @format A data frame with seventy five variables:
#' \describe{
#' \item{\code{Utility ID}, \code{Utility Name}}{Unique identification codes and names of the electricity utilities.}
#' \item{\code{Plant Code}, \code{Plant Name}}{Numeric codes and names of the power plants.}
#' \item{\code{State}}{}
#' \item{\code{County}}{}
#' \item{\code{Generator ID}}{}
#' \item{\code{Prime Mover}}{}
#' \item{\code{Unit Code}}{}
#' \item{\code{Ownership}}{}
#' \item{\code{Duct Burners}}{}
#' \item{\code{Can Bypass Heat Recovery Steam Generator?}}{}
#' \item{\code{RTO/ISO LMP Node Designation}}{}
#' \item{\code{RTO/ISO Location Designation for Reporting Wholesale Sales Data to FERC}}{}
#' \item{\code{Nameplate Capacity (MW)}}{}
#' \item{\code{Nameplate Power Factor}}{}
#' \item{\code{Summer Capacity (MW)}}{}
#' \item{\code{Winter Capacity (MW)}}{}
#' \item{\code{Minimum Load (MW)}}{}
#' \item{\code{Uprate or Derate Completed During Year}}{}
#' \item{\code{Month Uprate or Derate Completed}}{}
#' \item{\code{Year Uprate or Derate Completed}}{}
#' \item{\code{Status}}{}
#' \item{\code{Synchronized to Transmission Grid}}{}
#' \item{\code{Operating Month}}{}
#' \item{\code{Operating Year}}{}
#' \item{\code{Planned Retirement Month}}{}
#' \item{\code{Planned Retirement Year}}{}
#' \item{\code{Associated with Combined Heat and Power System}}{}
#' \item{\code{Sector Name}}{}
#' \item{\code{Sector}}{}
#' \item{\code{Topping or Bottoming}}{}
#' \item{\code{Energy Source 1, 2, 3, ... 6}}{}
#' \item{\code{Startup Source 1, 2, 3, ... 6}}{}
#' \item{\code{Solid Fuel Gasification System?}}{}
#' \item{\code{Carbon Capture Technology?}}{}
#' \item{\code{Turbines, Inverters, or Hydrokinetic Buoys}}{}
#' \item{\code{Time from Cold Shutdown to Full Load}}{}
#' \item{\code{Fluidized Bed Technology?}}{}
#' \item{\code{Pulverized Coal Technology?}}{}
#' \item{\code{Stoker Technology?}}{}
#' \item{\code{Other Combustion Technology?}}{}
#' \item{\code{Subcritical Technology?}}{}
#' \item{\code{Supercritical Technology?}}{}
#' \item{\code{Ultrasupercritical Technology?}}{}
#' \item{\code{Planned Net Summer Capacity Uprate (MW)}}{}
#' \item{\code{Planned Net Winter Capacity Uprate (MW)}}{}
#' \item{\code{Planned Uprate Month}}{}
#' \item{\code{Planned Uprate Year}}{}
#' \item{\code{Planned Net Summer Capacity Derate (MW)}}{}
#' \item{\code{Planned Net Winter Capacity Derate (MW)}}{}
#' \item{\code{Planned Derate Month}}{}
#' \item{\code{Planned Derate Year}}{}
#' \item{\code{Planned New Prime Mover}}{}
#' \item{\code{Planned Energy Source 1}}{}
#' \item{\code{Planned New Nameplate Capacity (MW)}}{}
#' \item{\code{Planned Repower Month}}{}
#' \item{\code{Planned Repower Year}}{}
#' \item{\code{Other Planned Modifications?}}{}
#' \item{\code{Other Modifications Month}}{}
#' \item{\code{Other Modifications Year}}{}
#' \item{\code{Cofire Fuels?}}{}
#' \item{\code{Switch Between Oil and Natural Gas?}}{}
#' \item{\code{Year}}{Year}
#' \item{\code{Technology}}{}
#' \item{\code{Turbines or Hydrokinetic Buoys}}{}
#' \item{\code{Multiple Fuels?}}{}
#' }
#'
"generators"

#' Net Generation
#'
#' Net monthly electricity generation in MWh over the years 2012-2020.
#' From EIA Form 923, Page 4.
#'
#' @format A data frame with twenty seven variables:
#' \describe{
#' \item{\code{PlantID}}{}
#' \item{\code{Combined Heat and Power}}{}
#' \item{\code{Plant}}{}
#' \item{\code{Operator}}{}
#' \item{\code{OperatorID}}{}
#' \item{\code{State}}{}
#' \item{\code{CensusRegion}}{}
#' \item{\code{NERCRegion}}{}
#' \item{\code{NAICS}}{}
#' \item{\code{SectorNumber}}{}
#' \item{\code{Sector}}{}
#' \item{\code{GeneratorID}}{}
#' \item{\code{PrimeMover}}{}
#' \item{\code{Jan ... Dec}}{}
#' \item{\code{YearToDate}}{}
#' \item{\code{Year}}{}
#' \item{\code{Respondent Frequency}}{}
#' \item{\code{BalancingAuthorityCode}}{}
#' }
#'
"net_generation"

#' Cooling
#'
#' Monthly entries for cooling of electricity generation plants over the years 2012-2020.
#' From EIA Form 923, Schedule 8.
#'
#' @format A data frame with twenty two variables:
#' \describe{
#' \item{\code{Year}}{}
#' \item{\code{Month}}{}
#' \item{\code{PlantID}}{}
#' \item{\code{CoolingID}}{}
#' \item{\code{CoolingType}}{}
#' \item{\code{CoolingStatus}}{}
#' \item{\code{HoursInService}}{}
#' \item{\code{Chlorine (thousand lbs)}}{}
#' \item{\code{Diversion (gpm)}}{}
#' \item{\code{Withdrawal (gpm)}}{}
#' \item{\code{Discharge (gpm)}}{}
#' \item{\code{Consumption (gpm)}}{}
#' \item{\code{FlowMethod}}{}
#' \item{\code{IntakeAvgTemp (F)}}{}
#' \item{\code{IntakeMaxTemp}}{}
#' \item{\code{DischargeAvgTemp}}{}
#' \item{\code{DischargeMaxTemp}}{}
#' \item{\code{TempMethod}}{}
#' \item{\code{Diversion (MGal)}}{}
#' \item{\code{Withdrawal (MGal)}}{}
#' \item{\code{Discharge (MGal)}}{}
#' \item{\code{Consumption (MGal)}}{}
#' }
#'
"cooling"

#' Detailed cooling information
#'
#' Net monthly electricity generation in MWh over the years 2012-2017.
#'
#' @format A data frame with sixty eight variables:
#' \describe{
#' \item{\code{Utility ID}}{}
#' \item{\code{State}}{}
#' \item{\code{Plant Code}}{}
#' \item{\code{Plant Name}}{}
#' \item{\code{Year}}{Year}
#' \item{\code{Month}}{}
#' \item{\code{Generator ID}}{}
#' \item{\code{Boiler ID}}{}
#' \item{\code{Cooling ID}}{}
#' \item{\code{Generator Primary Technology}}{}
#' \item{\code{Summer Capacity of Steam Turbines (MW)}}{}
#' \item{\code{Gross Generation from Steam Turbines (MWh)}}{}
#' \item{\code{Net Generation from Steam Turbines (MWh)}}{}
#' \item{\code{Summer Capacity Associated with Single Shaft Combined Cycle Units (MW)}}{}
#' \item{\code{Gross Generation Associated with Single Shaft Combined Cycle Units (MWh)}}{}
#' \item{\code{Net Generation Associated with Single Shaft Combined Cycle Units (MWh)}}{}
#' \item{\code{}}{}
#' \item{\code{}}{}
#' \item{\code{}}{}
#' \item{\code{Fuel Consumption from All Fuel Types (MMBTU)}}{}
#' \item{\code{}}{}
#' \item{\code{}}{}
#' \item{\code{}}{}
#' \item{\code{Coal Consumption (MMBTU)}}{}
#' \item{\code{Natural Gas Consumption (MMBTU)}}{}
#' \item{\code{Petroleum Consumption (MMBTU)}}{}
#' \item{\code{Biomass Consumption (MMBTU)}}{}
#' \item{\code{Other Gas Consumption (MMBTU)}}{}
#' \item{\code{Other Fuel Consumption (MMBTU)}}{}
#' \item{\code{Water Withdrawal Volume (Million Gallons)}}{}
#' \item{\code{Water Consumption Volume (Million Gallons)}}{}
#' \item{\code{Water Withdrawal Intensity Rate (Gallons / MWh)}}{}
#' \item{\code{}}{}
#' \item{\code{Water Withdrawal Rate per Fuel Consumption (Gallons / MMBTU)}}{}
#' \item{\code{}}{}
#' \item{\code{Cooling Unit Hours in Service}}{}
#' \item{\code{Average Distance of Water Intake Below Water Surface (Feet)}}{}
#' \item{\code{860 Cooling Type 1}}{}
#' \item{\code{860 Cooling Type 2}}{}
#' \item{\code{923 Cooling Type}}{}
#' \item{\code{Cooling System Type}}{}
#' \item{\code{Water Type}}{}
#' \item{\code{Water Source}}{}
#' \item{\code{Water Source Name}}{}
#' \item{\code{Water Discharge Name}}{}
#' \item{\code{Generator Status}}{}
#' \item{\code{Generator Inservice Month}}{}
#' \item{\code{Generator Inservice Year}}{}
#' \item{\code{Generator Retirement Month}}{}
#' \item{\code{Generator Retirement Year}}{}
#' \item{\code{Boiler Status}}{}
#' \item{\code{Boiler Inservice Month}}{}
#' \item{\code{Boiler Inservice Year}}{}
#' \item{\code{Boiler Retirement Month}}{}
#' \item{\code{Boiler Retirement Year}}{}
#' \item{\code{Cooling Status}}{}
#' \item{\code{Cooling Inservice Month}}{}
#' \item{\code{Cooling Inservice Year}}{}
#' \item{\code{Combined Heat and Power Generator?}}{}
#' \item{\code{}}{}
#' }
#'
"cooling_detail"
