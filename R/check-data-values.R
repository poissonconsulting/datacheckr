check_data_values_column <- function(column_name, data, values, data_name) {
  vector <- data[[column_name]]
  values <- values[names(values) == column_name]

  values <- check_vector_values_nulls(vector, values, column_name, data_name)
  if (identical(values, TRUE)) return(TRUE)
  value <- check_vector_values_class(vector, values, column_name, data_name)

  value <- check_vector_value_missing(vector, value, column_name, data_name)
  if (length(value) == 1) return(TRUE)
  vector <- rm_nas(vector)
  if (!length(vector)) return(TRUE)
  check_vector_value(vector, value, column_name, data_name)
}

check_data_values <- function(data, values, data_name) {
  if (is.null(values))
    return(invisible(data))
  column_names <- unique(names(values))
  vapply(column_names, FUN = check_data_values_column, logical(1), data = data, values = values,
         data_name = data_name)
  invisible(data)
}
