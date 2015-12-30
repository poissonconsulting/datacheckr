check_data_values_column <- function(column_name, data, values, substituted_data) {
  vector <- data[[column_name]]
  values <- values[names(values) == column_name]

  values <- check_vector_values_nulls(vector, values, column_name, substituted_data)
  if (identical(values, TRUE)) return(TRUE)
  value <- check_vector_values_class(vector, values, column_name, substituted_data)

  value <- check_vector_value_missing(vector, value, column_name, substituted_data)
  if (length(value) == 1) return(TRUE)
  check_vector_value(vector, value, column_name, substituted_data)
}

check_data_values <- function(data, values, substituted_data) {
  column_names <- sort(unique(names(values)))
  sapply(column_names, FUN = check_data_values_column, data = data, values = values,
         substituted_data = substituted_data)
  TRUE
}
