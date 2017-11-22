#' Check Vector
#'
#' Checks the class and values of a vector
#'
#' @param vector The vector to check.
#' @param value A vector specifying the class and values.
#' @param min_length A count of the minimum length.
#' @param max_length A count of the maximum length.
#' @param vector_name A string of the name of vector.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the vector.
#' @export
check_vector <- function(vector, value, min_length = 1, max_length = max_nrow(),
                         vector_name = substitute(vector)) {
  if (!is.character(vector_name)) vector_name <- deparse(vector_name)
  check_string_internal(vector_name)

  if (!is_vector(vector)) error(vector_name, " must be a vector")
  if (!is_vector(value)) error("value must be a vector")

  check_length(vector, min_length = min_length, max_length = max_length,
               x_name = vector_name)

  classes <- get_classes(list(value))
  if (!inherits(vector, classes))
    error(vector_name, " must be of class ", punctuate(classes))

  value <- check_vector_value_missing(vector, value, column_name = vector_name)
  if (length(value) == 1) return(invisible(vector))
  check_vector_value(vector, value, column_name = vector_name)
  invisible(vector)
}

#' Checks Flags
#'
#' @param x The flag(s) to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
#' @examples
#' check_flags(TRUE)
check_flags <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, c(TRUE, FALSE), vector_name = x_name)
}

#' Checks Ints
#'
#' @param x The integer(s) to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
#' @examples
#' try(check_ints(1))
check_ints <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, c(min_integer(), max_integer()), vector_name = x_name)
}

#' Checks Counts
#'
#' @param x The count(s) to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
#' @examples
#' check_counts(1L)
check_counts <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, c(0L, max_integer()), vector_name = x_name)
}

#' Checks Strings
#'
#' @param x The string(s) to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
#' @examples
#' check_strings("oeu")
check_strings <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, "", vector_name = x_name)
}

#' Checks Number
#'
#' @param x The number(s) to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
#' @examples
#' check_numbers(2)
check_numbers <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, 1, vector_name = x_name)
}

#' Checks Dates
#'
#' @param x The Date(s) to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
check_dates <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, as.Date("2000-01-01"), vector_name = x_name)
}

#' Checks Times
#'
#' @param x The scalar POSIXct to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @export
#' @examples
#' try(check_times(Sys.Date()))
check_times <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_vector(x, as.POSIXct("2000-01-01 00:00:00", tz = "UTC"),
               vector_name = x_name)
}
