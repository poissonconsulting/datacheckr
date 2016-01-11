check_stop <- function(...) stop(..., call. = FALSE)

is_named <- function(x) !is.null(names(x))

is_POSIXct <- function (x) inherits(x, "POSIXct")

plural <- function(x, n = 1, end = "") paste0(x, ifelse(n > 1, "s", ""), end)

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
