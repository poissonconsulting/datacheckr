#' Check Scalar
#'
#' Checks the class and values of a scalar
#'
#' @param scalar The scalar to check.
#' @param value A vector specifying the class and value.
#' @param scalar_name A string of the name of vector.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the scalar.
#' @seealso \code{\link{datacheckr}}
#' @export
check_scalar <- function(scalar, value, scalar_name = substitute(scalar)) {
  if (!is.character(scalar_name)) scalar_name <- deparse(scalar_name)
  check_string_internal(scalar_name)

  if (!is_scalar(scalar)) error(scalar_name, " must be a scalar")
  check_vector(scalar, value, min_length = 1, max_length = 1, vector_name = scalar_name)
}

#' Checks Flag
#'
#' @param x The flag to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
check_flag <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, c(TRUE, FALSE), scalar_name = x_name)
}

#' Checks Int
#'
#' @param x The scalar integer to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' try(check_int(1))
check_int <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, c(min_integer(), max_integer()), scalar_name = x_name)
}

#' Checks Count
#'
#' @param x The count to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
check_count <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, c(0L, max_integer()), scalar_name = x_name)
}

#' Checks String
#'
#' @param x The string to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
check_string <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, "", scalar_name = x_name)
}

#' Checks Number
#'
#' @param x The number to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
check_number <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, 1, scalar_name = x_name)
}

#' Checks Date
#'
#' @param x The Date to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
check_date <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, as.Date("2000-01-01"), scalar_name = x_name)
}

#' Checks Time
#'
#' @param x The scalar POSIXct to check.
#' @param x_name A string of the name of x.
#'
#' @return Throws an informative error or returns an invisible copy of
#' x.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' try(check_time(Sys.Date()))
check_time <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  check_string_internal(x_name)

  check_scalar(x, as.POSIXct("2000-01-01 00:00:00", tz = "UTC"),
               scalar_name = x_name)
}
