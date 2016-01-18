error_set <- function(value, column_name, data_name = NULL)
  UseMethod("error_set")

error_set.default <- function(value, column_name, data_name = NULL) {
  value <- sort(unique(value))
  if (length(value) <= 5)
    error(name_info(column_name, data_name),
               " must only include the permitted ",
               plural("value", length(value)), " ", punctuate(value, "and"))
  error(name_info(column_name, data_name), " includes non-permitted values")
}

error_set.character <- function(value, column_name, data_name = NULL) {
  value <- sort(unique(value))
  if (length(value) <= 3) {
    error(name_info(column_name, data_name),
               " must only include values which match the regular ",
               plural("expression", length(value)," "),
               punctuate(value, "or"))
  }
  error(name_info(column_name, data_name), " has incompatible factor levels")
}

error_set.factor <- function(value, column_name, data_name = NULL) {
  if (nlevels(value) <= 5) {
  error(name_info(column_name, data_name),
             " must be a factor with the ", plural("level", nlevels(value), " "),
             punctuate(levels(value), "and"))
  }
  error(name_info(column_name, data_name),
             " has incompatible factor levels")
}
