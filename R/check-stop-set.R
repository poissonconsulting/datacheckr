check_stop_set <- function(value, column_name, substituted_data)
  UseMethod("check_stop_set")

check_stop_set.default <- function(value, column_name, substituted_data) {
  value <- sort(unique(value))
  if (length(value) <= 5)
    check_stop("column ", column_name, " in ", substituted_data,
               " must only include the permitted ",
               plural("value", length(value)), " ", punctuate(value, "and"))
  check_stop("column ", column_name, " in ", substituted_data, " includes non-permitted values")
}

check_stop_set.character <- function(value, column_name, substituted_data) {
  value <- sort(unique(value))
  if (length(value) <= 3) {
    check_stop("column ", column_name, " in ", substituted_data,
               " must only include values which match the regular ",
               plural("expression", length(value)," "),
               punctuate(value, "or"))
  }
  check_stop("column ", column_name, " in ", substituted_data, " has incompatible factor levels")
}

check_stop_set.factor <- function(value, column_name, substituted_data) {
  if (nlevels(value) <= 5) {
  check_stop("column ", column_name, " in ", substituted_data,
             " must be a factor with the ", plural("level", nlevels(value), " "),
             punctuate(levels(value), "and"))
  }
  check_stop("column ", column_name, " in ", substituted_data,
             " has incompatible factor levels")
}
