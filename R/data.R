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
#' Electric utility information from EIA form 860 over the years 2013-2017.
#'
#' @format A data frame with twelve variables:
#' \describe{
#' \item{\code{Owner of Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Entity Type}}{}
#' \item{\code{Year}}{Year}
#' }
#'
#' For further details, see \url{http://www.ssa.gov/oact/NOTES/as120/LifeTables_Body.html#wp1168594}
#'
"utilities"

#' Plants
#'
#' Electric power generation plants in EIA form 860 over the years 2013-2017.
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
#' Electric power generators in EIA form 860 over the years 2013-2017
#'
#' @format A data frame with seventy five variables:
#' \describe{
#' \item{\code{Owner of Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Entity Type}}{}
#' \item{\code{Year}}{Year}
#' }
#'
"generators"

#' Net Generation
#'
#' Net monthly electricity generation in MWh over the years 2012-2017.
#'
#' @format A data frame with twenty seven variables:
#' \describe{
#' \item{\code{Owner of Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Entity Type}}{}
#' \item{\code{Year}}{Year}
#' }
#'
"net_generation"

#' Cooling
#'
#' Net monthly electricity generation in MWh over the years 2012-2017.
#'
#' @format A data frame with twenty two variables:
#' \describe{
#' \item{\code{Owner of Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Entity Type}}{}
#' \item{\code{Year}}{Year}
#' }
#'
"cooling"

#' Detailed cooling information
#'
#' Net monthly electricity generation in MWh over the years 2012-2017.
#'
#' @format A data frame with twenty seven variables:
#' \describe{
#' \item{\code{Owner of Plants Reported on Form?}}{}
#' \item{\code{Other Relationships with Plants Reported on Form?}}{}
#' \item{\code{Entity Type}}{}
#' \item{\code{Year}}{Year}
#' }
#'
"cooling_detail"
