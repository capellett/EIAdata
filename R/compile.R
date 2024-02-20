#' @export
#' @title Convert (and drop) month and year columns to a date column
#' @description Convert month and year to date
#' @param df a dataframe with a column for month and a column for year.
#' @param monthcol length 1 character vector name of the month column.
#' @param yearcol length 1 character vector name of the year column.
#' @param datecol length 1 character vector name of the year column.
monthyear_to_date <- function(df, monthcol='Month', yearcol='Year',
                              datecol='Date', dateFormat="%m %Y") {
  months <- df[,monthcol, drop=TRUE]
  months[is.na(months)] <- 12
  years <- df[,yearcol, drop=TRUE]
  df[, datecol] <- lubridate::as_date(zoo::as.yearmon(
    paste0(months, ' ', years),
    format=dateFormat), frac=1)
  df[, !(names(df) %in% c(monthcol, yearcol))]
}



# test <- monthyear_to_date(eia_generator, 'Operating Month', 'Operating Year', 'Operating Date')

#' @export
#' @title left join two dataframes, dropping extra copied columns
#' @description left join two dataframes, dropping extra copied columns
#' @param df1 a dataframe
#' @param df2 a dataframe
#' @param by a character vector of variables to join by
#' @param rename logical
join_and_drop <- function(df1, df2, by=NULL, rename=FALSE) {
  df <- dplyr::left_join(df1, df2, by)
  if(is.null(by)){
    by <- names(df1)[names(df1) %in% names(df2)]
  }
  df <- df[,!(names(df) %in% c(by, names(by)) ) ]
  if(is.character(rename)) {
    names(df)[(length(df)-(length(rename)-1)):length(df)] <- rename
  }
  df
}

#' @export
#' @title Create a column by pasting multiple columns together
#' @description Create a column by pasting multiple columns together
#' @param df dataframe
#' @param columns columns
#' @param new_col the new column name
#' @param collapse string to separate the values.
paste_columns <- function(df, columns, new_col='new_col', collapse='; ') {
  columns <- df[, columns]
  df <- df[, !(names(df) %in% names(columns))]
  columns <- columns %>% rowwise() %>%
    do( new_col = unique(.) %>% na.omit() %>%
          paste0(collapse=collapse) )
  df[, new_col] <- columns[,'new_col', drop=TRUE] %>% unlist()
  df
}


