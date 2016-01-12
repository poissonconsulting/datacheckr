#' Check Key
#'
#' Checks that the columns in a data frame represent a unique key.
#' To check the classes and values of the key columns use \code{\link{check_data}}.
#'
#' @param data The data frame to check.
#' @param colnames A character vector specifying the columns of the key.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the original data frame.
#' @seealso \code{\link{datacheckr}}
#' @export
check_key <- function(data, colnames = NULL, data_name = substitute(data)) {
  data_name <- as.character(data_name)
  if (!is_string(data_name)) check_stop("data_name must be a string")

  check_data_frame(data, data_name)
  if (!is.null(colnames)) {
    check_colnames(data, data_name, colnames)
  } else
    colnames <- colnames(data)
  key <- data[as.character(colnames)]
  if (anyDuplicated(key)) {
    check_stop("columns colnames in ", data_name, " are not a unique key")
  }
  invisible(data)
}
