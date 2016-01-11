check_vector_values_nulls <- function(vector, values, column_name, substituted_data) {
  nulls <- vapply(values, is.null, logical(1))
  if (all(nulls)) {
    if (!is.null(vector))
      check_stop(substituted_data, " must not include column ", column_name)
    return(TRUE)
  }
  if (any(nulls) && is.null(vector))
    return(TRUE)
  values[!nulls]
}

check_vector_values_class <- function(vector, values, column_name, substituted_data) {
  classes <- get_classes(values)

  if (!inherits(vector, classes)) {
    check_stop("column ", column_name, " in ", substituted_data, " must be of class ",
              punctuate(classes))
  }
  values[[1]]
}
