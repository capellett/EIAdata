# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

#' @title utilities
#' @format A dataframe with 37029 rows and 12 columns.
#'
#' @description Annual entries for electric utility information from EIA form 860 over the years 2013-2020.
#' \describe{
#'   \item{\code{Utility ID}}{an integer value that identifies each utility}
#'   \item{\code{Utility Name}}{the name of the utility}
#'   \item{\code{Street Address}}{Description of the street address}
#'   \item{\code{City}}{Description of the city}
#'   \item{\code{State}}{Description of the state}
#'   \item{\code{Zip}}{Description of the zip code}
#'   \item{\code{Owner of Plants Reported on Form?}}{"Y", NA}
#'   \item{\code{Operator of Plants Reported on Form?}}{"Y", NA}
#'   \item{\code{Asset Manager of Plants Reported on Form?}}{"Y", NA}
#'   \item{\code{Other Relationships with Plants Reported on Form?}}{"Y", NA}
#'   \item{\code{Entity Type}}{A categorical variable indicating the type of entity
#'     that owns and/or operates the plants reported on this form. It includes the following
#'     specific values: "IND" (Individual), "Q" (Quarterly), "M" (Monthly), "COM" (Commercial),
#'     "C" (Cooperative), "I" (Industrial), NA (Not Available), "P" (Political Subdivision),
#'     "F" (Federally-Owned Utility), "S" (State-Owned Utility).
#'     Note: The actual values in the dataset may vary and should be verified against
#'     the current dataset version. Please see EIA-860 Instructions}
#'   \item{\code{Year}}{2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020}
#' }
#' For further details, see \url{http://www.ssa.gov/oact/NOTES/as120/LifeTables_Body.html#wp1168594}
"utilities"

#' @title plants
#' @format A dataframe with 80641 rows and 45 columns.
#'
#' @description Annual entries for electric power generation plants in EIA form 860 over the years 2013-2020.
#'
#' \describe{
#' \item{\code{Utility ID}, \code{Utility Name}}{Unique identification codes and names of the electricity utilities.}
#' \item{\code{Plant Code}, \code{Plant Name}}{EIA-assigned plant code}
#' \item{\code{County}}{County Name},
#' \item{\code{Latitude}, \code{Longitude}}{Physical location of each plant, including address and geographic coordinates.}
#' \item{\code{NERC Region}}{North American Electric Reliability Corporation (NERC)region in which the plant operates}
#' \item{\code{Balancing Authority Code}}{A 5-character code for the balancing authority managing supply, demand, and interchanges within an electrically defined area. May or may not be the same as the Owner of Transmission/Distribution Facilities.}
#' \item{\code{Balancing Authority Name}}{Name of Balancing Authority}
#' \item{\code{Name of Water Source}}{The name of the principal source from which cooling water or water for generating power for hydroelectric plants is obtained. If #'water is from an underground aquifer, provide name of aquifer, if known. If name of 'aquifer is not known,  “Wells.”  “Municipality” if the water is from a municipality.  “UNK” for planned facilities for which the water source is not known.  “NA” for
#' plants that do not use a water source for cooling or hydroelectric generation.}
#' \item{\code{Primary Purpose (NAICS Code)}}{North American Industry Classification System (NAICS) code 'that best describes the primary purpose of the plant.Electric utility plants and
#' independent power producers whose primary purpose is generating electricity for sale will generally use code 22. For generators whose primary business is an industrial or
#' commercial process (e.g., paper mills, refineries, chemical plants, etc.) and for which generating electricity is a secondary purpose, use a code other than 22.}
#' \item{\code{Regulatory Status}}{Indicates whether the plant is regulated (RE) or non-regulated (NR) }
#' \item{\code{Sector}}{Plant-level sector name, designated by the primary purpose, regulatory status and plant-level combined heat and power status.Options include Commercial, Electric Utility, Industrial, Non-CHP Independent Power Producer (IPP), CHP IPP.}
#' \item{\code{Sector Name}}{Plant-level sector number, designated by the primary purpose, regulatory status and plant-level combined heat and power status, "1 = Electric Utility , 2 = Independent Power Producer, Non-Combined Heat and Power, 3 = Independent Power Producer, Combined Heat and Power, 4 = Commercial, Non-Combined Heat and Power,
#' 5 = Commercial, Combined Heat and Power, 6 = Industrial, Non-Combined Heat and Power, 7 = Industrial, Combined Heat and Power" }
#' \item{\code{Net Metering (for facilities with solar and wind generation)}}{desc}
#' \item{\code{FERC Cogeneration Status}}{Indicates of whether the plant has FERC qualifying facility cogenerator status.Yes , No}
#' \item{\code{FERC Cogeneration Docket Number}}{The docket number relating to the FERC qualifying facility cogenerator status}
#' \item{\code{FERC Small Power Producer Status}}{Indicates of whether the plant has FERC qualifying facility small power producer status}
#' \item{\code{FERC Small Power Producer Docket Number}}{The docket number relating to the FERC qualifying facility small power producer status}
#' \item{\code{FERC Exempt Wholesale Generator Status}}{Indicates of whether the plant has FERC qualifying facility exempt wholesale generator status}
#' \item{\code{FERC Exempt Wholesale Generator Docket Number}}{The docket number relating to the FERC qualifying facility exempt wholesale generator status}
#' \item{\code{Ash Impoundment?}}{Is there an ash impoundment (e.g. pond, reservoir) at the plant? }
#' \item{\code{Ash Impoundment Lined?}}{If there is an ash impoundment at the plant, is the impoundment lined?}
#' \item{\code{Ash Impoundment Status}}{If there is an ash impoundment at the plant,  the ash impoundment status as of December 31 of the reporting year}
#' \item{\code{Transmission or Distribution System Owner}}{Name of the owner of the transmission or distribution system to which the plant is interconnected}
#' \item{\code{Transmission or Distribution System Owner ID}}{EIA-assigned code for owner of transmission/distribution system to which the plant is interconnected}
#' \item{\code{Transmission or Distribution System Owner State}}{State location for owner of transmission/distribution system to which the plant is interconnected}
#' \item{\code{Grid Voltage (kV)}}{Plant's grid voltage at point of interconnection to transmission or distibution facilities. If the plant is interconnected to more than three transmission / distriubtion facilites, the three highest grid voltages are reported}
#' \item{\code{Grid Voltage 2 (kV)}}{Plant's grid voltage at point of interconnection to transmission or distibution facilities. If the plant is interconnected to more than three transmission / distriubtion facilites, the three highest grid voltages are reported}
#' \item{\code{Grid Voltage 3 (kV)}}{Plant's grid voltage at point of interconnection to transmission or distibution facilities}{Plant's grid voltage at point of interconnection to transmission or distibution facilities. If the plant is interconnected to more than three transmission / distriubtion facilites, the three highest grid voltages are reported}
#' \item{\code{Natural Gas Pipeline Name}}{desc}
#' \item{\code{Year}}{2013 to 2019}
#' \item{\code{Energy Storage}}{Indicates if the facility have energy storage capabilities}
#' \item{\code{Natural Gas LDC Name}}{Names of Local Distribution Company (LDC), connected to natural gas burning power plants}
#' \item{\code{Natural Gas Pipeline Name 1}}{The name of the owner or operator of natural gas pipeline that connects directly to this facility or that connects to a lateral pipeline owned by this facility}
#' \item{\code{Natural Gas Pipeline Name 2}}{The name of the owner or operator of natural gas pipeline that connects directly to this facility or that connects to a lateral pipeline owned by this facility}
#' \item{\code{Natural Gas Pipeline Name 3}}{The name of the owner or operator of natural gas pipeline that connects directly to this facility or that connects to a lateral pipeline owned by this facility}
#' \item{\code{Pipeline Notes}}{Additional owner or operator of natural gas pipeline}
#' \item{\code{Natural Gas Storage}}{Indicates if the facility have on-site storage of natural gas}
#' \item{\code{Liquified Natural Gas Storage}}{Indicates if the facility have the capability to store the natural gas in the form of liquefied natural gas}
#' }
#'
"plants"

#' @title generators
#' @format A dataframe with 169422 rows and 61 columns.
#'
#' @description Annual entries for each electric power generators in EIA form 860 over the years 2013-2020
#'
#' \describe{
#' \item{\code{Utility ID}, \code{Utility Name}}{Unique identification codes and names of the electricity utilities.}
#' \item{\code{Plant Code}, \code{Plant Name}}{Numeric codes and names of the power plants.}
#' \item{\code{State}}{}
#' \item{\code{County}}{}
#' \item{\code{Generator ID}}{The unique generator identification commonly used by plant management.}
#' \item{\code{Prime Mover}}{The prime mover codes.
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     BA \tab Energy Storage, Battery \cr
#'     CE \tab Energy Storage, Compressed Air \cr
#'     CP \tab Energy Storage, Concentrated Solar Power \cr
#'     FW \tab Energy Storage, Flywheel \cr
#'     PS \tab Energy Storage, Reversible Hydraulic Turbine (Pumped Storage) \cr
#'     ES \tab Energy Storage, Other (specify in SCHEDULE 7) \cr
#'     ST \tab Steam Turbine, including nuclear, geothermal and solar steam (does not include combined cycle) \cr
#'     GT \tab Combustion (Gas) Turbine (does not include the combustion turbine part of a combined cycle; see code CT, below) \cr
#'     IC \tab Internal Combustion Engine (diesel, piston, reciprocating) \cr
#'     CA \tab Combined Cycle Steam Part \cr
#'     CT \tab Combined Cycle Combustion Turbine Part \cr
#'     CS \tab Combined Cycle Single Shaft (combustion turbine and steam turbine share a single generator) \cr
#'     CC \tab Combined Cycle Total Unit (use only for plants/generators that are in planning stage, for which specific generator details cannot be provided) \cr
#'     HA \tab Hydrokinetic, Axial Flow Turbine \cr
#'     HB \tab Hydrokinetic, Wave Buoy \cr
#'     HK \tab Hydrokinetic, Other (specify in SCHEDULE 7) \cr
#'     HY \tab Hydroelectric Turbine (includes turbines associated with delivery of water by pipeline) \cr
#'     BT \tab Turbines Used in a Binary Cycle (including those used for geothermal applications) \cr
#'     PV \tab Photovoltaic \cr
#'     WT \tab Wind Turbine, Onshore \cr
#'     WS \tab Wind Turbine, Offshore \cr
#'     FC \tab Fuel Cell \cr
#'     OT \tab Other (specify in SCHEDULE 7) \cr
#'   }
#' }
#' \item{\code{Unit Code}}{ If this generator
#' operates as a single unit with another generator (including as a combined cycle unit),
#' enter a unique 4-character code for the unit. All generators that operate as a unit must
#' have the same unit code. Leave blank if this generator does not operate as a single unit
#' with another generator}
#' \item{\code{Ownership}}{Ownership for each generator using the following codes:
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     S \tab Single ownership by respondent \cr
#'     J \tab Jointly owned with another entity \cr
#'     W \tab Wholly owned by an entity other than respondent \cr
#'   }
#' }
#' \item{\code{Duct Burners}}{"Yes" if 1) the generator has a combined cycle prime mover code of "Combined Cycle Steam Part (CA)", "Combined Cycle Single Shaft (CS)," or "Combined Cycle Total Unit (CC)," and 2) if the unit has duct-burners for supplementary firing of the turbine exhaust gas. Otherwise, check "No."}
#' \item{\code{Can Bypass Heat Recovery Steam Generator?}}{"Yes" if the generator has a combined cycle prime mover code of "Combined Cycle Combustion Turbine Part (CT)" or "Combined Cycle Total Unit (CC)" and 2) the combustion turbine can operate while bypassing the heat recovery steam generator. Otherwise, "No."}
#' \item{\code{RTO/ISO LMP Node Designation}}{
#' this generator operates in an electric system operated by a Regional Transmission
#' Organization (RTO) or Independent System Operator (ISO) and the RTO/ISO calculates
#' a nodal Locational Marginal Price (LMP) at the generator location, then provide the nodal
#'designation used to identify the price node in RTO/ISO LMP price reports.
#'}
#' \item{\code{RTO/ISO Location Designation for Reporting Wholesale Sales Data to FERC}}{
#'  If this generator operates in an electric
#' system operated by a Regional Transmission Organization (RTO) or Independent
#' System Operator (ISO) and the generator’s wholesale sales transaction data is reported
#' to FERC for the Electric Quarterly Report, then provide the designation used to report the
#' specific location of the wholesale sales transactions to FERC.}
#' \item{\code{Nameplate Capacity (MW)}}{
#' the highest value on the generator nameplate in MW rounded to the nearest tenth, as measured in
#' alternating current (AC). If the nameplate capacity is expressed in kilovolt amperes
#' (kVA), first convert the nameplate capacity to kilowatts by multiplying the corresponding
#' power factor by the kVA and then convert to megawatts by dividing by 1,000. Round this
#' value to the nearest tenth.}
#' \item{\code{Nameplate Power Factor}}{ The power factor stamped on the generator nameplate. This should be the same power factor used
#' to convert the generator’s kilovolt-ampere rating (kVA) to megawatts (MW) as directed for
#' line 1a above. Solar photovoltaic systems, wind turbines, batteries, fuel cells, and
#' flywheels may skip this question.}
#' \item{\code{Summer Capacity (MW)}}{The net summer capacity}
#' \item{\code{Winter Capacity (MW)}}{The net winter capacity}
#' \item{\code{Minimum Load (MW)}}{Minimum load (MW) at which the unit can operate continuously}
#' \item{\code{Uprate or Derate Completed During Year}}{“Yes” if an uprate or derate project was implemented during the
#' reporting year. “No” if it was not. If both an uprate and derate were implemented
#' during the reporting year}
#' \item{\code{Month Uprate or Derate Completed}}{}
#' \item{\code{Year Uprate or Derate Completed}}{}
#' \item{\code{Status}}{Operating and service statuses:
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     OP \tab Operating – in service (commercial operation) and producing some electricity. Includes peaking units that are run on an as needed (intermittent or seasonal) basis. \cr
#'     SB \tab Standby/Backup – available for service but not normally used (has little or no generation during the year) for this reporting period. \cr
#'     OS \tab Out of service – was not used for some or all of the reporting period and is NOT expected to be returned to service in the next calendar year. \cr
#'     OA \tab Out of service – was not used for some or all of the reporting period but is expected to be returned to service in the next calendar year. \cr
#'     RE \tab Retired – no longer in service and not expected to be returned to service. \cr
#'   }
#' }
#' \item{\code{Synchronized to Transmission Grid}}{If the status code is standby (SB),  “Yes” if the generator is currently
#' equipped to be synchronized to the grid when operating. “No” if it is not.}
#' \item{\code{Operating Month}}{Month the generator began commercial operation}
#' \item{\code{Operating Year}}{Year the generator began commercial operation}
#' \item{\code{Planned Retirement Month}}{Month the generator retired}
#' \item{\code{Planned Retirement Year}}{Year the generator retired}
#' \item{\code{Associated with Combined Heat and Power System}}{ “Yes” if this generator is associated with a combined heat and power system. “No” if it is not}
#' \item{\code{Sector Name}}{Plant-level sector number, designated by the primary purpose, regulatory status and plant-level combined heat and power status}
#' \item{\code{Sector}}{Plant-level sector name, designated by the primary purpose, regulatory status and plant-level combined heat and power status}
#' \item{\code{Topping or Bottoming}}{If the generator is associated with a combined heat and power system, indicates whether the generator is part of a topping cycle or a bottoming cycle'}
#' \item{\code{Energy Source 1, 2, 3, ... 6}}{The code representing the predominant (1-6) type of energy that fuels the generator}
#' \item{\code{Startup Source 1, 2, 3, ... 6}}{The code representing the first, second, third or fourth start-up and flame stabilization energy source used by the combustion unit(s) associated with this generator}
#' \item{\code{Solid Fuel Gasification System?}}{Indicates whether the generator is part of a solid fuel gasification system}
#' \item{\code{Carbon Capture Technology?}}{Indicates whether the generator uses carbon capture technology}
#' \item{\code{Turbines, Inverters, or Hydrokinetic Buoys}}{Number of wind turbines, or hydrokinetic buoys}
#' \item{\code{Time from Cold Shutdown to Full Load}}{The minimum amount of time required to bring the unit to full load from shutdown}
#' \item{\code{Fluidized Bed Technology?}}{Indicates whether the generator uses fluidized bed technology (Yes / No)}
#' \item{\code{Pulverized Coal Technology?}}{Indicates whether the generator uses pulverized coal technology(Yes / No)}
#' \item{\code{Stoker Technology?}}{Indicates whether the generator uses stoker technology (Yes / No)}
#' \item{\code{Other Combustion Technology?}}{Indicates whether the generator uses other combustion technologies (Yes / No)}
#' \item{\code{Subcritical Technology?}}{Indicates whether the generator uses subcritical technology (Yes / No)}
#' \item{\code{Supercritical Technology?}}{Indicates whether the generator uses supercritical technology (Yes / No)}
#' \item{\code{Ultrasupercritical Technology?}}{Indicates whether the generator uses ultra-supercritical technology (Yes/No)}
#' \item{\code{Planned Net Summer Capacity Uprate (MW)}}{Increase in summer capacity expected to be realized from the modification to the equipment}
#' \item{\code{Planned Net Winter Capacity Uprate (MW)}}{Increase in winter capacity expected to be realized from the uprate modification to the equipment}
#' \item{\code{Planned Uprate Month}}{Planned effective month that the generator is scheduled to enter operation after the uprate modification}
#' \item{\code{Planned Uprate Year}}{Planned effective year that the generator is scheduled to enter operation after the uprate modification}
#' \item{\code{Planned Net Summer Capacity Derate (MW)}}{Decrease in summer capacity expected to be realized from the derate modification to the equipment}
#' \item{\code{Planned Net Winter Capacity Derate (MW)}}{Decrease in winter capacity expected to be realized from the derate modification to the equipment}
#' \item{\code{Planned Derate Month}}{Planned effective month that the generator is scheduled to enter operation after the derate modification}
#' \item{\code{Planned Derate Year}}{Planned effective year that the generator is scheduled to enter operation after the derate modification}
#' \item{\code{Planned New Prime Mover}}{New prime mover for the planned repowered generator}
#' \item{\code{Planned Energy Source 1}}{New energy source code for the planned repowered generator}
#' \item{\code{Planned New Nameplate Capacity (MW)}}{The expected new namplate capacity for the generator}
#' \item{\code{Planned Repower Month}}{Planned effective month that the generator is scheduled to enter operation after the repowering is complete}
#' \item{\code{Planned Repower Year}}{Planned effective year that the generator is scheduled to enter operation after the repowering is complete}
#' \item{\code{Other Planned Modifications?}}{Indicates whether there are there other modifications planned for the generator}
#' \item{\code{Other Modifications Month}}{Planned effective month that the generator is scheduled to enter commercial operation after any other planned modification is complete}
#' \item{\code{Other Modifications Year}}{Planned effective year that the generator is scheduled to enter commercial operation after any other planned modofication is complete}
#' \item{\code{Cofire Fuels?}}{Can the generator co-fire fuels? (Yes / No)}
#' \item{\code{Switch Between Oil and Natural Gas?}}{Indicates whether the generator switch between oil and natural gas(Yes / No)}
#' \item{\code{Year}}{Year}
#' \item{\code{Technology}}{Generator Technology}
#' \item{\code{Turbines or Hydrokinetic Buoys}}{Number of wind turbines, or hydrokinetic buoys  }
#' \item{\code{Multiple Fuels?}}{Can the generator burn multiple fuels? (Yes/No)}
#' }
#'
"generators"

#' @title net_generation
#' @format A dataframe with 34954 rows and 29 columns.
#'
#' @description Net monthly electricity generation in MWh over the years 2012-2020. From EIA Form 923, Page 4.
#'
#' \describe{
#' \item{\code{PlantID}}{EIA-assigned plant code}
#' \item{\code{Combined Heat and Power}}{Indicates whether the generator is associated with a combined heat and power system (Yes/No)}
#' \item{\code{Plant}}{Plant name}
#' \item{\code{Operator}}{Is the reporting entity an operator of power plants reported on Schedule 2 of the form?}
#' \item{\code{OperatorID}}{ID of operator}
#' \item{\code{State}}{State for owner}
#' \item{\code{CensusRegion}}{Census Region}
#' \item{\code{NERCRegion}}{North American Electric Reliability Corporation (NERC)region in which the plant operates}
#' \item{\code{NAICS}}{North American Industry Classification System (NAICS) code 'that best describes the primary purpose of the plant.Electric utility plants and
#'independent power producers whose primary purpose is generating electricity for sale will generally use code 22. For generators whose primary business is an industrial or
#'commercial process (e.g., paper mills, refineries, chemical plants, etc.) and for which generating electricity is a secondary purpose, use a code other than 22.}
#' \item{\code{SectorNumber}}{Plant-level sector number, designated by the primary purpose, regulatory status, and plant-level combined heat and power status:
#'   \tabular{ll}{
#'     Number \tab Description \cr
#'     1 \tab Electric Utility \cr
#'     2 \tab Independent Power Producer, Non-Combined Heat and Power \cr
#'     3 \tab Independent Power Producer, Combined Heat and Power \cr
#'     4 \tab Commercial, Non-Combined Heat and Power \cr
#'     5 \tab Commercial, Combined Heat and Power \cr
#'     6 \tab Industrial, Non-Combined Heat and Power \cr
#'     7 \tab Industrial, Combined Heat and Power \cr
#'   }
#' }
#' \item{\code{Sector}}{Plant-level sector name, designated by the primary purpose, regulatory status and plant-level combined heat and power status}
#' \item{\code{GeneratorID}}{Generator identification number}
#' \item{\code{PrimeMover}}{EIA assigned code for the prime mover (i.e., the engine, turbine, water wheel, or similar machine that drives an electric generator):
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     BA \tab Energy Storage, Battery \cr
#'     CE \tab Energy Storage, Compressed Air \cr
#'     CP \tab Energy Storage, Concentrated Solar Power \cr
#'     FW \tab Energy Storage, Flywheel \cr
#'     PS \tab Energy Storage, Reversible Hydraulic Turbine (Pumped Storage) \cr
#'     ES \tab Energy Storage, Other (specify in SCHEDULE 7) \cr
#'     ST \tab Steam Turbine, including nuclear, geothermal and solar steam (does not include combined cycle) \cr
#'     GT \tab Combustion (Gas) Turbine (does not include the combustion turbine part of a combined cycle; see code CT, below) \cr
#'     IC \tab Internal Combustion Engine (diesel, piston, reciprocating) \cr
#'     CA \tab Combined Cycle Steam Part \cr
#'     CT \tab Combined Cycle Combustion Turbine Part \cr
#'     CS \tab Combined Cycle Single Shaft (combustion turbine and steam turbine share a single generator) \cr
#'     CC \tab Combined Cycle Total Unit (use only for plants/generators that are in planning stage, for which specific generator details cannot be provided) \cr
#'     HA \tab Hydrokinetic, Axial Flow Turbine \cr
#'     HB \tab Hydrokinetic, Wave Buoy \cr
#'     HK \tab Hydrokinetic, Other (specify in SCHEDULE 7) \cr
#'     HY \tab Hydroelectric Turbine (includes turbines associated with delivery of water by pipeline) \cr
#'     BT \tab Turbines Used in a Binary Cycle (including those used for geothermal applications) \cr
#'     PV \tab Photovoltaic \cr
#'     WT \tab Wind Turbine, Onshore \cr
#'     WS \tab Wind Turbine, Offshore \cr
#'     FC \tab Fuel Cell \cr
#'     OT \tab Other (specify in SCHEDULE 7) \cr
#'   }
#' }

#' \item{\code{Jan ... Dec}}{}
#' \item{\code{YearToDate}}{}
#' \item{\code{Year}}{}
#' \item{\code{Respondent Frequency}}{}
#' \item{\code{BalancingAuthorityCode}}{The plant's balancing authority}
#' }
#'
"net_generation"

#' @title cooling
#' @format A dataframe with 149285 rows and 21 columns.
#' @description Monthly entries for cooling of electricity generation plants over the years 2012-2020. From EIA Form 923, Schedule 8.
#' \describe{
#' \item{\code{Year}}{}
#' \item{\code{Month}}{}
#' \item{\code{PlantID}}{EIA-assigned plant code}
#' \item{\code{CoolingID}}{Cooling system identification number}
#' \item{\code{CoolingType}}{Types of cooling systems:
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     DC \tab Dry (air) cooling system \cr
#'     HRC \tab Hybrid: cooling pond(s) or canal(s) with dry cooling \cr
#'     HRF \tab Hybrid: forced draft cooling tower(s) with dry cooling \cr
#'     HRI \tab Hybrid: induced draft cooling tower(s) with dry cooling \cr
#'     OC \tab Once through with cooling pond(s) \cr
#'     ON \tab Once through without cooling pond(s) \cr
#'     RC \tab Recirculating with cooling pond(s) or canal(s) \cr
#'     RF \tab Recirculating with forced draft cooling tower(s) \cr
#'     RI \tab Recirculating with induced draft cooling tower(s) \cr
#'     RN \tab Recirculating with natural draft cooling tower(s) \cr
#'     HT \tab Helper Tower \cr
#'     OT \tab Other (specify in SCHEDULE 7) \cr
#'   }
#' }
#' \item{\code{CoolingStatus}}{Cooling system status:
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     CN \tab Cancelled (previously reported as “planned”) \cr
#'     CO \tab New unit under construction \cr
#'     OP \tab Operating (in commercial service or out of service less than 365 days) \cr
#'     OS \tab Out of service (365 days or longer) \cr
#'     PL \tab Planned (expected to go into commercial service within 10 years) \cr
#'     RE \tab Retired (no longer in service and not expected to be returned to service) \cr
#'     SB \tab Standby (or inactive reserve); i.e., not normally used, but available for service \cr
#'     SC \tab Cold Standby (Reserve); deactivated (usually requires 3 to 6 months to reactivate) \cr
#'     TS \tab Operating under test conditions (not in commercial service) \cr
#'   }
#' }

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

#' @title cooling_detail
#' @format A dataframe with 584820 rows and 70 columns.
#'
#' @description Detailed cooling information.
#' \describe{
#' \item{\code{Utility ID}}{EIA-assigned identification number for the company that is responsible for the day-to-day operations of the generator}
#' \item{\code{State}}{State of operator}
#' \item{\code{Plant Code}}{Code of plant}
#' \item{\code{Plant Name}}{Name of plant}
#' \item{\code{Year}}{Year}
#' \item{\code{Month}}{}
#' \item{\code{Generator ID}}{Generator identification number}
#' \item{\code{Boiler ID}}{Boiler identification number}
#' \item{\code{Cooling ID}}{Cooling system identification number}
#' \item{\code{Generator Primary Technology}}{High level description of the technology used by the generator to produce electricity}
#' \item{\code{Summer Capacity of Steam Turbines (MW)}}{}
#' \item{\code{Gross Generation from Steam Turbines (MWh)}}{}
#' \item{\code{Net Generation from Steam Turbines (MWh)}}{}
#' \item{\code{Summer Capacity Associated with Single Shaft Combined Cycle Units (MW)}}{}
#' \item{\code{Gross Generation Associated with Single Shaft Combined Cycle Units (MWh)}}{}
#' \item{\code{Net Generation Associated with Single Shaft Combined Cycle Units (MWh)}}{}
#' \item{\code{Fuel Consumption from All Fuel Types (MMBTU)}}{}
#' \item{\code{Coal Consumption (MMBTU)}}{Coal consumed}
#' \item{\code{Natural Gas Consumption (MMBTU)}}{Natural gas consumed}
#' \item{\code{Petroleum Consumption (MMBTU)}}{Petroleum consumed}
#' \item{\code{Biomass Consumption (MMBTU)}}{Biomass consumption}
#' \item{\code{Other Gas Consumption (MMBTU)}}{Other gas consumption}
#' \item{\code{Other Fuel Consumption (MMBTU)}}{Fuel consumption}
#' \item{\code{Water Withdrawal Volume (Million Gallons)}}{Volume of water withdrawals}
#' \item{\code{Water Consumption Volume (Million Gallons)}}{Volume of water consumed}
#' \item{\code{Water Withdrawal Intensity Rate (Gallons / MWh)}}{}
#' \item{\code{Water Withdrawal Rate per Fuel Consumption (Gallons / MMBTU)}}{}
#' \item{\code{Cooling Unit Hours in Service}}{}
#' \item{\code{Average Distance of Water Intake Below Water Surface (Feet)}}{}
#' \item{\code{860 Cooling Type 1}}{Type of cooling system}
#' \item{\code{860 Cooling Type 2}}{Type of cooling system}
#' \item{\code{923 Cooling Type}}{}
#' \item{\code{Cooling System Type}}{}
#' \item{\code{Water Type}}{
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     BR \tab Brackish Water \cr
#'     FR \tab Fresh Water \cr
#'     BE \tab Reclaimed Water (ex: treated wastewater effluent) \cr
#'     SA \tab Saline Water \cr
#'     OT \tab Other (specify in SCHEDULE 7) \cr
#'   }
#' }
#' \item{\code{Water Source}}{
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     SW \tab Surface Water (ex: river, canal, bay) \cr
#'     GW \tab Ground Water (ex: aquifer, well) \cr
#'     PD \tab Plant Discharge Water (ex: wastewater treatment plant discharge) \cr
#'     OT \tab Other (specify in SCHEDULE 7) \cr
#'   }
#' }
#' \item{\code{Water Source Name}}{Name of river, lake, or water source that provides cooling water}
#' \item{\code{Water Discharge Name}}{Name of river, lake, or water source that cooling water is discharged into.}
#' \item{\code{Generator Status}}{}
#' \item{\code{Generator Inservice Month}}{}
#' \item{\code{Generator Inservice Year}}{}
#' \item{\code{Generator Retirement Month}}{}
#' \item{\code{Generator Retirement Year}}{}
#' \item{\code{Boiler Status}}{
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     CN \tab Cancelled (previously reported as “planned”) \cr
#'     CO \tab New unit under construction \cr
#'     OP \tab Operating (in commercial service or out of service less than 365 days) \cr
#'     OS \tab Out of service (365 days or longer) \cr
#'     PL \tab Planned (expected to go into commercial service within 10 years) \cr
#'     RE \tab Retired (no longer in service and not expected to be returned to service) \cr
#'     SB \tab Standby (or inactive reserve); i.e., not normally used, but available for service \cr
#'     SC \tab Cold Standby (Reserve); deactivated (usually requires 3 to 6 months to reactivate) \cr
#'     TS \tab Operating under test conditions (not in commercial service) \cr
#'   }
#' }
#' \item{\code{Boiler Inservice Month}}{}
#' \item{\code{Boiler Inservice Year}}{}
#' \item{\code{Boiler Retirement Month}}{}
#' \item{\code{Boiler Retirement Year}}{}
#' \item{\code{Cooling Status}}{
#'   \tabular{ll}{
#'     Code \tab Description \cr
#'     CN \tab Cancelled (previously reported as “planned”) \cr
#'     CO \tab New unit under construction \cr
#'     OP \tab Operating (in commercial service or out of service less than 365 days) \cr
#'     OS \tab Out of service (365 days or longer) \cr
#'     PL \tab Planned (expected to go into commercial service within 10 years) \cr
#'     RE \tab Retired (no longer in service and not expected to be returned to service) \cr
#'     SB \tab Standby (or inactive reserve); i.e., not normally used, but available for service \cr
#'     SC \tab Cold Standby (Reserve); deactivated (usually requires 3 to 6 months to reactivate) \cr
#'     TS \tab Operating under test conditions (not in commercial service) \cr
#'   }
#' }
#' \item{\code{Cooling Inservice Month}}{The actual or projected in-service month of this cooling system}
#' \item{\code{Cooling Inservice Year}}{The actual or projected in-service month of this cooling system}
#' \item{\code{Combined Heat and Power Generator?}}{Indicates whether the generator is associated with a combined heat and power system (Yes/No)}
#' }
#'
"cooling_detail"

#' @title AEO2019_dat
#' @format A dataframe with 35 rows and 11 columns.
#'
#' @description Year 2019: Industrial Sector Macroeconomic Indicators (Value of Shipments).
#' \describe{
#' \item{\code{Type}}{Type of sector. Manufacturing or Non-manufacturing}
#' \item{\code{Sector}}{kind of sector}
#' \item{\code{Years of projections}}{Years}
#' }
"AEO2019_dat"

#' @title AEO2020_dat
#' @format A dataframe with 35 rows and 35 columns.
#'
#' @description Year 2020: Industrial Sector Macroeconomic Indicators (Value of Shipments).
#' \describe{
#' \item{\code{Type}}{Type of sector. Manufacturing or Non-manufacturing}
#' \item{\code{Sector}}{kind of sector}
#' \item{\code{Years of projections}}{Years}
#' }
"AEO2020_dat"

#' @title AEO2021_dat
#' @format A dataframe with 35 rows and 34 columns.
#'
#' @description Year 2021: Industrial Sector Macroeconomic Indicators (Value of Shipments).
#' \describe{
#' \item{\code{Type}}{Type of sector. Manufacturing or Non-manufacturing}
#' \item{\code{Sector}}{kind of sector}
#' \item{\code{Years of projections}}{Years}
#' }
"AEO2021_dat"

#' @title AEO2023_dat
#' @format A dataframe with 35 rows and 32 columns.
#' @description Year 2023: Industrial Sector Macroeconomic Indicators (Value of Shipments).
#' \describe{
#' \item{\code{Type}}{Type of sector. Manufacturing or Non-manufacturing}
#' \item{\code{Sector}}{kind of sector}
#' \item{\code{Years of projections}}{Years}
#' }
"AEO2023_dat"
