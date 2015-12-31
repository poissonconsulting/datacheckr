check_stop <- function(...) stop(..., call. = FALSE)

is_named <- function(x) !is.null(names(x))

punctuate <- function(x, qualifier = "or", speech = "'") {
  x <- paste0(speech, x, speech)
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
#' @export
max_integer <- function() { .Machine$integer.max }
