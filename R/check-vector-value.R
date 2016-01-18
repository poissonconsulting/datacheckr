check_vector_value_missing <- function(vector, value, column_name, data_name = NULL) {
  if (!length(value) || !length(vector))
    return(TRUE)
  missing <- any(is.na(value))
  value <- value[!is.na(value)]

  if (!missing && any(is.na(vector)))
      error(name_info(column_name, data_name), " cannot include missing values")

  if (!length(value)) {
    if (!all(is.na(vector)))
        error(name_info(column_name, data_name), " can only include missing values")
    return(TRUE)
  }
  value
}

check_vector_value <- function(vector, value, column_name, data_name = NULL)
  UseMethod("check_vector_value")

check_vector_value.default <- function(vector, value, column_name, data_name = NULL) {
  if (length(value) == 2) {
    range <- range(vector, na.rm = TRUE)
    value <- sort(value)
    if (range[1] < value[1] || range[2] > value[2])
        error("the values in ", name_info(column_name, data_name),
                   " must lie between ", value[1], " and ", value[2])
    return(TRUE)
  }
  if (!all(vector %in% value))
    error_set(value, column_name, data_name)
  TRUE
}

check_vector_value.logical <- function(vector, value, column_name, data_name = NULL) {
  value <- unique(value)
  if (length(value) == 2)
    return(TRUE)
  if (!all(vector == value))
      error(name_info(column_name, data_name), " can only include ",
                 value, " values")
  TRUE
}

check_vector_value.character <- function(vector, value, column_name, data_name = NULL) {
  if (length(value) == 2) {
    if (!all(grepl(value[1], vector, perl = TRUE) & grepl(value[2], vector, perl = TRUE)))
      error(name_info(column_name, data_name), " contains strings that do not match both regular expressions ", punctuate(sort(value), qualifier = "and"))
    return(TRUE)
  }
  regexp <- paste0("(", paste(value, collapse = ")|(") , ")")
  if (!all(grepl(regexp, vector, perl = TRUE)))
    error_set(value, column_name, data_name)
  TRUE
}

check_vector_value.factor <- function(vector, value, column_name, data_name = NULL) {
  if (length(value) == 2) {
    if (!all(as.character(value) %in% levels(vector)))
        error(name_info(column_name, data_name), " lacks factor levels ", punctuate(sort(as.character(value)), qualifier = "and"))
    return(TRUE)
  }
  if (!identical(levels(value), levels(vector)))
    error_set(value, column_name, data_name)
  TRUE
}
