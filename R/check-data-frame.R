#' Check Data Frame
#'
#' Checks that data is a data frame.
#'
#' @param data The data frame to check.
#' @param data_name A string of the name of data.
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_data_frame <- function(data, data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  check_string_internal(data_name)

  if (!is.data.frame(data)) error(data_name, " must be a data frame")
  if (anyDuplicated(colnames(data)))
    error(data_name, " must have unique column names")
  invisible(data)
}
