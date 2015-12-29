deck_stop <- function(...) stop(..., call. = FALSE)
is_named <- function(x) !is.null(names(x))

punctuate <- function(x, qualifier = "or", speech = "'") {
  x <- paste0(speech, x, speech)
  if (length(x) == 1)
    return(x)
  n <- length(x)
  paste(paste(x[-n], collapse = ", "), qualifier, x[n])
}

classes <- function() {
  c("NULL", "logical", "integer", "numeric", "character", "factor", "Date")
}

deck_data <- function(data, substituted_data) {
  if (!is.data.frame(data)) deck_stop(substituted_data, " must be a data frame")
  TRUE
}


deck_values <- function(values, substituted_values) {
  if (!is.list(values)) deck_stop(substituted_values, " must be a list")
  if (!is_named(values)) deck_stop(substituted_values, " must be a named list")
  implemented <- vapply(values, inherits, logical(1), classes())
  if (any(!implemented))
    deck_stop(substituted_values, " must be a named list of vectors of class ",
              punctuate(classes()))
  TRUE
}

#' Data Check
#'
#' The deck (short for data check) function takes a data frame data and a named
#' list values that specifies the columns in data and their associated values.
#' If data passes all the conditions set by values then deck returns the original
#' data frame (which allows the function to be inserted in piping chains).
#' Otherwise deck throws an informative error.
#'
#' If values is unspecified deck simply checks that data is a data frame.
#'
#' @param data The data frame to check.
#' @param values A named list specifying the columns and their associated values.
#'
#' @return Throws an informative error or returns the original data object.
#' @export
deck <- function(data, values = NULL) {
  substituted_data <- substitute(data)
  substituted_values <- substitute(values)

  deck_data(data, substituted_data)
  if (!is.null(values)) {
    deck_values(values, substituted_values)
  }
  data
}
