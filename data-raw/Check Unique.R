
df<- generators

# Create a list to store unique values for each column
unique_values_list <- list()

# Find the maximum number of unique values in any column
max_length <- max(sapply(df, function(col) length(unique(col))))

# Loop through each column in df and store unique values in the list
for(col in names(df)) {
  unique_col_values <- unique(df[[col]])
  length(unique_col_values) <- max_length  # Extend the vector length to max_length
  unique_values_list[[col]] <- unique_col_values
}

# Convert the list to a dataframe
unique_values_df <- as.data.frame(unique_values_list, stringsAsFactors = FALSE)
