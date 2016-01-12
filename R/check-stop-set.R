check_stop_set <- function(value, column_name, data_name)
  UseMethod("check_stop_set")

check_stop_set.default <- function(value, column_name, data_name) {
  value <- sort(unique(value))
  if (length(value) <= 5)
    check_stop("column ", column_name, " in ", data_name,
               " must only include the permitted ",
               plural("value", length(value)), " ", punctuate(value, "and"))
  check_stop("column ", column_name, " in ", data_name, " includes non-permitted values")
}

check_stop_set.character <- function(value, column_name, data_name) {
  value <- sort(unique(value))
  if (length(value) <= 3) {
    check_stop("column ", column_name, " in ", data_name,
               " must only include values which match the regular ",
               plural("expression", length(value)," "),
               punctuate(value, "or"))
  }
  check_stop("column ", column_name, " in ", data_name, " has incompatible factor levels")
}

check_stop_set.factor <- function(value, column_name, data_name) {
  if (nlevels(value) <= 5) {
  check_stop("column ", column_name, " in ", data_name,
             " must be a factor with the ", plural("level", nlevels(value), " "),
             punctuate(levels(value), "and"))
  }
  check_stop("column ", column_name, " in ", data_name,
             " has incompatible factor levels")
}
