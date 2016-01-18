#' Check Key
#'
#' Checks that columns in a data frame represent a unique key.
#'
#' By default (\code{key = NULL}) all the columns are checked.
#'
#' @inheritParams check_data_frame
#' @param key A character vector of the column names representing the key.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the data.
#' @seealso \code{\link{datacheckr}}
#' @export
#'
check_key <- function(data, key = NULL, data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  data <- check_data_frame(data, data_name)
  data <- check_colnames(data, colnames = key, exclusive = FALSE,
                         ordered = FALSE, data_name = data_name)

  if (is.null(key)) key <- colnames(data)

  key <- as.character(key)
  if (anyDuplicated(data[key])) {
      error(plural("column", length(key), " "),
                 punctuate(key, "and"), " in ", data_name, " must be a unique key")
  }
  invisible(data)
}
