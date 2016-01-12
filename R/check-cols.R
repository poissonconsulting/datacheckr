#' Check Cols
#'
#' Checks the names and order of columns in data.
#'
#' @inheritParams check_data_frame
#' @param colnames A character vector of the column names.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_cols <- function(data, colnames = NULL, exclusive = FALSE, ordered = FALSE,
                       data_name = substitute(data)) {
  data_name <- as.character(data_name)
  data <- check_data_frame(data, data_name = data_name)
  data <- check_colnames(data, colnames = colnames, exclusive = exclusive,
                         ordered = ordered, data_name = data_name)
  invisible(data)
}
