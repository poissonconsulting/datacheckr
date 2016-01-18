#' Check Rows
#'
#' Checks the number of rows in data.
#'
#' By default (\code{min_row = 1}) data must include at least one row.
#'
#' @inheritParams check_data_frame
#' @param min_row A count of the minimum number of rows.
#' @param max_row A count of the maximum number of rows.
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' try(check_rows(data.frame()))
#' try(check_rows(data.frame(x = 1), 2))
check_rows <- function(data, min_row = 1, max_row = max_nrow(), data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  data <- check_data_frame(data, data_name = data_name)

  check_count_internal(min_row)
  check_count_internal(max_row)

  if (max_row < min_row) error("max_row must not be less than min_row")

  nrow <- nrow(data)

  if (nrow < min_row)
    error(data_name, " must have at least ", min_row, plural(" row", min_row))
  if (nrow > max_row)
    error(data_name, " must have no more than ", max_row, plural(" row", min_row))
  invisible(data)
}
