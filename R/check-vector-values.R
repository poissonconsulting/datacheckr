check_vector_values <- function(vector, value, column_name, substituted_data)
  UseMethod("check_vector_values")

check_vector_values.default <- function(vector, value, column_name, substituted_data) {
  if (length(value) == 2) {
    range <- range(vector, na.rm = TRUE)
    value <- sort(value)
    if (range[1] < value[1] || range[2] > value[2])
      check_stop("the values in column ", column_name, " in ", substituted_data, " must lie between ", value[1], " and ", value[2])
    return(TRUE)
  }
  if (!all(vector %in% value))
    check_stop("column ", column_name, " in ", substituted_data, " includes non-permitted values")
  TRUE
}

check_vector_values.logical <- function(vector, value, column_name, substituted_data) {
  value <- unique(value)
  if (length(value) == 2)
    return(TRUE)
  if (!all(vector == value))
    check_stop("column ", column_name, " in ", substituted_data, " can only include ",
              value, " values")
  TRUE
}

check_vector_values.character <- function(vector, value, column_name, substituted_data) {
  if (length(value) == 2) {
    if (!all(grepl(value[1], vector) & grepl(value[2], vector)))
      check_stop("column ", column_name, " in ", substituted_data, " contains strings that do not match both regular expressions ", punctuate(value, qualifier = "and"))
    return(TRUE)
  }
  value <- paste0("(", paste(value, collapse = ")|(") , ")")
  if (!all(grepl(value, vector)))
    check_stop("column ", column_name, " in ", substituted_data, " includes non-permitted strings")
  TRUE
}

