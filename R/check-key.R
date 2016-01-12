check_colnames <- function(data, substituted_data, colnames) {
  if (!(is.character(colnames) | is.factor(colnames)))
    check_stop("colnames must be a character vector")
  if (!length(colnames))
    check_stop("colnames must a non-zero length character vector")
  if (anyDuplicated(colnames))
    check_stop("colnames must be unique")
  if (!any(colnames %in% colnames(data))) {
    check_stop("colnames must be in ", substituted_data)
  }
  TRUE
}

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
check_key <- function(data, colnames = NULL) {
  substituted_data <- substitute(data)

  check_data_frame(data, substituted_data, min_row = 0, max_row = max_nrow())
  if (!is.null(colnames)) {
    check_colnames(data, substituted_data, colnames)
  } else
    colnames <- colnames(data)
  key <- data[as.character(colnames)]
  if (anyDuplicated(key)) {
    check_stop("columns colnames in ", substituted_data, " are not a unique key")
  }
  invisible(data)
}
