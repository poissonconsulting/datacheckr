#' Check Cols
#'
#' Checks the names and order of columns in data.
#'
#' By default (\code{colnames = NULL}) data must include at least one column.
#' To check for no columns set \code{colnames = character(0)}.
#'
#' @inheritParams check_data_frame
#' @param colnames A character vector of the column names.
#' @param exclusive A flag indicating whether data can include additional columns.
#' @param ordered A flag indicating whether the order of the columns has to match.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_cols <- function(data, colnames = NULL, exclusive = FALSE, ordered = FALSE,
                       data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  data <- check_data_frame(data, data_name = data_name)
  data <- check_colnames(data, colnames = colnames, exclusive = exclusive,
                         ordered = ordered, data_name = data_name)
  invisible(data)
}
