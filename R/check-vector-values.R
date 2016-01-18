check_vector_values_nulls <- function(vector, values, column_name, data_name) {
  nulls <- vapply(values, is.null, logical(1))
  if (all(nulls)) {
    if (!is.null(vector))
      error(data_name, " must not include column ", column_name)
    return(TRUE)
  }
  if (any(nulls) && is.null(vector))
    return(TRUE)
  values[!nulls]
}

check_vector_values_class <- function(vector, values, column_name, data_name) {
  if(is.null(vector))
    error(data_name, " must have column '", column_name, "'")

  classes <- get_classes(values)

  if (!inherits(vector, classes)) {
    error("column ", column_name, " in ", data_name, " must be of class ",
              punctuate(classes))
  }
  values[[1]]
}
