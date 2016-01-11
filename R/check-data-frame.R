check_min_max_row <- function(nrow, substituted_data, min_row, max_row) {
  if (!(is.integer(min_row) | is.numeric(min_row))) check_stop("min_row must be a number")
  if (!(is.integer(max_row) | is.numeric(max_row))) check_stop("max_row must be a number")

  if (min_row < 0) check_stop("min_row must not be less than 0")
  if (max_row < min_row) check_stop("max_row must not be less than min_row")

  min_row <- floor(min_row)
  max_row <- floor(max_row)

  if (nrow < min_row)
    check_stop(substituted_data, " must have at least ", min_row, plural(" row", min_row))
  if (nrow > max_row)
    check_stop(substituted_data, " must have no more than ", max_row, plural(" row", min_row))
  TRUE
}

check_data_frame <- function(data, substituted_data, min_row, max_row) {
  if (!is.data.frame(data)) check_stop(substituted_data, " must be a data frame")
  if (anyDuplicated(colnames(data)))
    check_stop(substituted_data, " must be a data frame with unique column names")

  check_min_max_row(nrow = nrow(data), substituted_data, min_row, max_row)
  TRUE
}
