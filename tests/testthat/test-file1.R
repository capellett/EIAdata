#*******************************************************************************************#
#     Testing: monthyear_to_date                                                            #
#*******************************************************************************************#

library(testthat)
library(lubridate)
library(zoo)

# Load function

source("C:/Users/Sangha/OneDrive - Clemson University/Desktop/Sangha/Packages/EIAdata/R/compile.R")


#*******************************************************************************************#
# Testing: join_and_drop
# Tests cover:
# 1. checking that the join is performed correctly.
# 2. extra columns are dropped.
# 3. renaming functionality works if specified.
#*******************************************************************************************#
library(testthat)
library(dplyr)


test_that("join_and_drop performs left join correctly", {
  df1 <- data.frame(id = 1:3, value1 = c("A", "B", "C"))
  df2 <- data.frame(id = 2:4, value2 = c("D", "E", "F"))

  result <- join_and_drop(df1, df2, by = "id")

  # Check if result is a dataframe
  expect_true(is.data.frame(result))

  # Check the correct number of rows and columns
  expect_equal(nrow(result), 3)
  expect_equal(ncol(result), 2) # This is different from the normal left join.
  #  The function is coded to also remove the "ID"

  # Check if the join is performed correctly
  expected_result <- data.frame(value1 = c("A", "B", "C"), value2 = c(NA, "D", "E"))
  expect_equal(result, expected_result)
})

# test_that("join_and_drop drops extra copied columns", {
#   df1 <- data.frame(id = 1:3, value = c("A", "B", "C"))
#   df2 <- data.frame(id = 1:3, value = c("X", "Y", "Z"), extra = 1:3)
#
#   result <- join_and_drop(df1, df2, by = "id")
#
#
# expect_false("value.y" %in% names(result))
# expect_false("extra" %in% names(result))
# expect_true("value.x" %in% names(result))
# })

test_that("join_and_drop renames columns if requested", {
  df1 <- data.frame(id = 1:3, value1 = c("A", "B", "C"))
  df2 <- data.frame(id = 2:4, value2 = c("D", "E", "F"))

  result <- join_and_drop(df1, df2, by = "id", rename = c("new_value1", "new_value2"))

  # Check if the columns are correctly renamed
  expect_true(all(c( "new_value1", "new_value2") %in% names(result)))
})


