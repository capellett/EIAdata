


# List all files in the /data folder
datasets <- list.files("data")
datasets <- sub("\\.rda$", "", datasets)


get_dim <- function(dataset_name) {
  # Construct the package-dataset expression
  dataset_expr <- paste0("EIAdata::", dataset_name)

  # Evaluate the expression in the global environment to get the dataset
  dataset <- eval(parse(text = dataset_expr), envir = .GlobalEnv)

  # Return the dimensions along with the dataset name
  c(Dataset = dataset_name, Rows = nrow(dataset), Columns = ncol(dataset))
}

# Apply the function to each dataset
dataset_info <- t(sapply(datasets, get_dim))

# Convert the matrix to a dataframe
dataset_info_df <- as.data.frame(dataset_info, stringsAsFactors = FALSE)

# Set proper column classes
dataset_info_df$Rows <- as.integer(dataset_info_df$Rows)
dataset_info_df$Columns <- as.integer(dataset_info_df$Columns)
dataset_info_df$format_doc <- paste0("#' @format A dataframe with ", dataset_info_df$Rows, " rows and ", dataset_info_df$Columns, " columns.")
rownames(dataset_info_df) <- NULL


#############################################################
library(roxygen2)
library(dplyr)

# Path to the R directory of your package
r_dir <- "R/"

for (i in 1:nrow(dataset_info_df)) {


  dataset_name <- dataset_info_df[i,1]   ##Chnage the row number and run one by one (this is done intentionally)



  # Path to the R script containing all dataset documentations
  r_script_path <- file.path(r_dir, "data.R")

  # Check if the R script exists
  if (!file.exists(r_script_path)) {
    warning(paste("The R script does not exist:", r_script_path))
    return(NULL)
  }

  # Read the lines from the R script
  lines <- readLines(r_script_path)

  # Get the dataset information
  dataset_info <- dataset_info_df[dataset_info_df$Dataset == dataset_name, ]

  if (nrow(dataset_info) == 1) {
    num_rows <- dataset_info$Rows
    num_cols <- dataset_info$Columns

    # Construct the new @format line
    new_format_line <- paste0("#' @format A dataframe with ", num_rows, " rows and ", num_cols, " columns.")

    # Find the line number of the @title line for this dataset
    title_line_index <- grep(paste0("^#' @title ", dataset_name, "\\b"), lines)

    # Ensure that a @title line was found
    if (length(title_line_index) == 0) {
      warning(paste("No @title found for dataset:", dataset_name))
      return(NULL)
    }

    # Find the @format line within the block of this dataset's documentation
    format_line_index <- grep("^#' @format", lines[(title_line_index+1):length(lines)])
    format_line_index <- format_line_index + title_line_index  # Adjusting index to be relative to the whole file


    lines <- append(lines, new_format_line, after = title_line_index)


    # Write the modified content back to the R script
    writeLines(lines, r_script_path)
  } else {
    warning(paste("Dataset", dataset_name, "not found in dataset_info_df!"))
  }

}




# This removed all formated lines





for (i in 1:nrow(dataset_info_df)) {
  dataset_name <- dataset_info_df[i, 1]   ## Change the row number and run one by one (this is done intentionally)

  # Path to the R script containing all dataset documentations
  r_script_path <- file.path(r_dir, "data.R")

  # Check if the R script exists
  if (!file.exists(r_script_path)) {
    warning(paste("The R script does not exist:", r_script_path))
    return(NULL)
  }

  # Read the lines from the R script
  lines <- readLines(r_script_path)

  # Get the dataset information
  dataset_info <- dataset_info_df[dataset_info_df$Dataset == dataset_name, ]

  if (nrow(dataset_info) == 1) {
    num_rows <- dataset_info$Rows
    num_cols <- dataset_info$Columns

    # Construct the new @format line
    new_format_line <- paste0("#' @format A dataframe with ", num_rows, " rows and ", num_cols, " columns.")

    # Find the line number of the @title line for this dataset
    title_line_index <- grep(paste0("^#' @title ", dataset_name, "\\b"), lines)

    # Ensure that a @title line was found
    if (length(title_line_index) == 0) {
      warning(paste("No @title found for dataset:", dataset_name))
      return(NULL)
    }

    # Find all @format lines within the block of this dataset's documentation
    format_line_indices <- grep("^#' @format", lines[(title_line_index + 1):length(lines)]) + title_line_index
    format_line_indices <- format_line_indices[format_line_indices > title_line_index]

    # Check if there are multiple @format lines
    if (length(format_line_indices) > 1) {
      # Keep only the first @format line and remove others
      lines <- lines[-format_line_indices[-1]]
    }

    # Write the modified content back to the R script
    writeLines(lines, r_script_path)
  } else {
    warning(paste("Dataset", dataset_name, "not found in dataset_info_df!"))
  }
}
