#' Check Key
#'
#' Checks that the columns in a data frame represent a unique key.
#'
#' @param data The data frame to check.
#' @param values A named list specifying the columns of the key and
#' their associated classes and values.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the original data frame.
#' @seealso \code{\link{datacheckr}}
#' @export
check_key <- function(data, values = NULL) {
  substituted_data <- substitute(data)

  check_data_frame(data, substituted_data, min_row = 0, max_row = max_nrow())
  if (!is.null(values)) {
    check_values(values)
    check_data_values(data, values, substituted_data)
    key <- data[unique(names(values))]
  } else
    key <- data

  invisible(data)
}
