
# Create dummy dataset that covers various scenarios:

# It should convert month and year columns into a single date column within the same dataframe.
# If the month value is NA, it should default to December (12).
# The resulting date should be the first day of the given month and year.
# It should drop the original month and year columns from the dataframe.
# The name of the new date column should be as specified by the datecol parameter.

library(testthat)
library(lubridate)

test_that("monthyear_to_date function works correctly", {
  # Prepare a sample dataframe
  df <- data.frame(
    Month = c(1, 4, 7, 10, 12, NA, 2),
    Year = c(2020, 2021, 2022, 2023, 2024, 2025, 2020)
  )

  # Apply the function
  transformed_df <- monthyear_to_date(df)


  # 2. Check if Month and Year columns are removed
  expect_false("Month" %in% names(transformed_df))
  expect_false("Year" %in% names(transformed_df))

  # 3. Specific value checks for the last day of the month
  expect_equal(transformed_df[1], as.Date("2020-01-31"))
  expect_equal(transformed_df[2], as.Date("2021-04-30"))
  expect_equal(transformed_df[3], as.Date("2022-07-31"))
  expect_equal(transformed_df[4], as.Date("2023-10-31"))
  expect_equal(transformed_df[5], as.Date("2024-12-31"))
  expect_equal(transformed_df[6], as.Date("2025-12-31"))
  expect_equal(transformed_df[7], as.Date("2020-02-29"))

  # 4. Ensure original month and year columns are dropped (already checked)

  # Additional test for custom 'datecol' name
  custom_transformed_df <- monthyear_to_date(df, monthcol = "Month", yearcol = "Year", datecol = "CustomDate")
  # expect_true("CustomDate" %in% names(custom_transformed_df))
  expect_false("Month" %in% names(custom_transformed_df))
  expect_false("Year" %in% names(custom_transformed_df))
  # You can add specific value checks for "CustomDate" column as needed
})




























