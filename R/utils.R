is_flag <- function(x)  is.logical(x) && length(x) == 1 && !is.na(x)
is_string <- function(x)  (is.character(x) || is.factor(x)) && length(x) == 1 && !is.na(x)
is_count <- function(x)  (is.integer(x) || is.numeric(x)) && length(x) == 1 &&
  !is.na(x) && x >= 0 && identical(as.numeric(x), floor(x))
is_named <- function(x) !is.null(names(x))

equal <- function(x, y) isTRUE(all.equal(x, y, check.names = FALSE))

is_POSIXct <- function(x) inherits(x, "POSIXct")

check_stop <- function(...) stop(..., call. = FALSE)

check_data_name <- function(data_name)
  if (!is_string(data_name)) check_stop("data_name must be a string")

plural <- function(x, n = 1, end = "") paste0(x, ifelse(n > 1, "s", ""), end)
isare <- function(n) ifelse(n > 1, "are", "is")

punctuate <- function(x, qualifier = "or") {
  if (!(is.logical(x) || is.integer(x) || is.numeric(x)))
    x <- paste0("'", as.character(x), "'")
  if (length(x) == 1)
    return(x)
  n <- length(x)
  paste(paste(x[-n], collapse = ", "), qualifier, x[n])
}

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

#' Maximum Integer Value
#'
#' A wrapper for \code{.Machine$integer.max}
#' which defines the maximum integer value for the machine.
#'
#' @return A count of the maximum integer value.
#' @seealso \code{\link{datacheckr}}
#' @export
max_integer <- function() .Machine$integer.max

#' Maximum Number of Rows
#'
#' A wrapper for \code{2^31 - 1}
#' which defines the \emph{theoretical}
#' maximum number of rows in a data.frame.
#'
#' @return A count of the maximum number of possible rows.
#' @seealso \code{\link{datacheckr}}
#' @export
max_nrow <- function() as.integer(2 ^ 31 - 1)
