deck_stop <- function(...) stop(..., call. = FALSE)
is_named <- function(x) !is.null(names(x))

deck_data <- function(data, substituted_data) {
  if (!is.data.frame(data)) deck_stop(substituted_data, " must be a data frame")
  TRUE
}

deck_values <- function(values, substituted_values) {
  if (!is.list(values)) deck_stop(substituted_values, " must be a list")
  if (!is_named(values)) deck_stop(substituted_values, " must be a named list")
  TRUE
}

#' Data Check
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
  deck_values(values, substituted_values)
  data
}
