#' Check Values
#'
#' Checks the class and values of columns in data.
#'
#' @inheritParams check_data_frame
#' @param values A named list specifying the columns and
#' their associated classes and values.
#' @param unique A string indicating if columns must only be defined in values.
#' @param nulls A string indicating if values can be NULL.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_values <- function(data, values = NULL, unique = TRUE, nulls = FALSE,
                         data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  data <- check_data_frame(data, data_name = data_name)

  values <- check_values_values(values, unique = unique, nulls = nulls)
  data <- check_data_values(data, values, data_name)
  invisible(data)
}
