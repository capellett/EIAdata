library(testthat)
library(dplyr)

test_that("paste_columns function correctly concatenates and removes columns", {
  df <- data.frame(
    Col1 = c("A", "B", "C"),
    Col2 = c("D", "E", "F"),
    Col3 = c(1, 2, 3),
    Col4 = c(4, 5, 6),
    Col5 = c("G", "H", "I")
  )

  # Correct expected combined values based on the concatenation of 'Col1' and 'Col2'
  expected_combined <- c("A;D", "B;E", "C;F")
  new_col_name <- "CombinedCols" # Correct name for the new concatenated column as specified in the function call

  # Apply the function, ensuring to specify the 'new_col' argument correctly
  transformed_df <- paste_columns(df, columns = c("Col1", "Col2"), new_col = new_col_name, collapse = ";")

  # 1. Check if the new column is added with the correct name
  expect_true(new_col_name %in% names(transformed_df))

  # 2. Verify the original columns are removed
  expect_false("Col1" %in% names(transformed_df)) # Correct case to match the original column names
  expect_false("Col2" %in% names(transformed_df))

  # 3. Check the content of the new column against expected values
  expect_equal(transformed_df[[new_col_name]], expected_combined)

  # Additionally, ensure other columns remain unaffected
  expect_true("Col3" %in% names(transformed_df))
  expect_true("Col4" %in% names(transformed_df))
  expect_true("Col5" %in% names(transformed_df))
})

