deck_vector_values <- function(vector, value, column_name, substituted_data)
  UseMethod("deck_vector_values")

deck_vector_values.default <- function(vector, value, column_name, substituted_data) {
  if (length(value) == 2) {
    range <- range(vector, na.rm = TRUE)
    value <- sort(value)
    if (range[1] < value[1] || range[2] > value[2])
      deck_stop("the values in column ", column_name, " in ", substituted_data, " must lie between ", value[1], " and ", value[2])
    return(TRUE)
  }
  if (!all(vector %in% value))
    deck_stop("column ", column_name, " in ", substituted_data, " includes non-permitted values")
  TRUE
}

deck_vector_values.logical <- function(vector, value, column_name, substituted_data) {
  value <- unique(value)
  if (length(value) == 2)
    return(TRUE)
  if (!all(vector == value))
    deck_stop("column ", column_name, " in ", substituted_data, " can only include ",
value, " values")
  TRUE
}

deck_vector_values.logical <- function(vector, value, column_name, substituted_data) {
  value <- unique(value)
  if (length(value) == 2)
    return(TRUE)
  if (!all(vector == value))
    deck_stop("column ", column_name, " in ", substituted_data, " can only include ",
value, " values")
  TRUE
}



