is_flag <- function(x)  is.logical(x) && length(x) == 1 && !is.na(x)
is_string <- function(x)  (is.character(x) || is.factor(x)) && length(x) == 1 && !is.na(x)
is_count <- function(x)  (is.integer(x) || is.numeric(x)) && length(x) == 1 &&
  !is.na(x) && x >= 0 && identical(as.numeric(x), floor(x))
is_named <- function(x) !is.null(names(x))

if_names <- function(x) {
  if (is_named(x))
    return(names(x))
  x
}

is_vector <- function(x) is.atomic(x)
is_scalar <- function(x) is.atomic(x) && length(x) == 1

equal <- function(x, y) isTRUE(all.equal(x, y, check.names = FALSE))

is_POSIXct <- function(x) inherits(x, "POSIXct")

error <- function(...) stop(..., call. = FALSE)

check_string_internal <- function(x)
  if (!is_string(x)) error(substitute(x), " must be a string")

check_flag_internal <- function(x)
  if (!is_flag(x)) error(substitute(x), " must be a flag")

check_count_internal <- function(x)
  if (!is_count(x)) error(substitute(x), " must be a count")

plural <- function(x, n = 1, end = "") paste0(x, ifelse(n != 1, "s", ""), end)
isare <- function(n) ifelse(n > 1, "are", "is")

punctuate <- function(x, qualifier = "or") {
  if (!(is.logical(x) || is.integer(x) || is.numeric(x)))
    x <- paste0("'", as.character(x), "'")
  if (length(x) == 1)
    return(x)
  n <- length(x)
  paste(paste(x[-n], collapse = ", "), qualifier, x[n])
}

rm_nas <- function(x) x[!is.na(x)]

classes <- function() {
  c("NULL", "logical", "integer", "numeric", "character", "factor", "Date", "POSIXct")
}

get_class <- function(x) {
  logical_vector <- inherits(x, classes(), which = TRUE) == 1
  classes()[logical_vector]
}

get_classes <- function(values) {
  vapply(values, get_class, character(1))
}

name_info <- function(column_name, data_name) {
  if (!is.null(data_name))
    return(paste("column", column_name, "in", data_name))
  return(column_name)
}

#' Maximum Integer Value
#'
#' A wrapper for \code{.Machine$integer.max}
#' which defines the maximum integer value for the machine.
#'
#' @return A count of the maximum integer value.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' max_integer()
max_integer <- function() .Machine$integer.max

#' Minimum Integer Value
#'
#' A wrapper for \code{-.Machine$integer.max}
#' which defines the minimum integer value for the machine.
#'
#' @return A int of the minimum integer value.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' min_integer()
min_integer <- function() -.Machine$integer.max

#' Maximum Number of Rows
#'
#' A wrapper for \code{2^31 - 1}
#' which defines the \emph{theoretical}
#' maximum number of rows in a data.frame.
#'
#' @return A count of the maximum number of possible rows.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' max_nrow()
max_nrow <- function() as.integer(2 ^ 31 - 1)
