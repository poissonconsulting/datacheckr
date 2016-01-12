#' Check Rows
#'
#' Checks the number of rows in data.
#'
#' @inheritParams check_data_frame
#' @param min_row A count of the minimum number of rows.
#' @param max_row A count of the maximum number of rows.
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_rows <- function(data, min_row = 0, max_row = max_nrow(), data_name = substitute(data)) {
  data_name <- as.character(data_name)
  data <- check_data_frame(data, data_name = data_name)

  if (!is_count(min_row)) check_stop("min_row must be a count")
  if (!is_count(max_row)) check_stop("max_row must be a count")

  if (min_row < 0) check_stop("min_row must not be less than 0")
  if (max_row < min_row) check_stop("max_row must not be less than min_row")

  nrow <- nrow(data)

  if (nrow < min_row)
    check_stop(data_name, " must have at least ", min_row, plural(" row", min_row))
  if (nrow > max_row)
    check_stop(data_name, " must have no more than ", max_row, plural(" row", min_row))
  invisible(data)
}
