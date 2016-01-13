#' Check Data2
#'
#' Checks a data frame's rows, columns, classes and values and key.
#'
#' \code{check_data2} enforces some constraints.
#' By default it requires data to have rows (and therefore columns).
#' It also does not allow NULLs in values and
#' requires column names in values to be unique.
#' However it does not require that data only includes the columns in value.
#'
#' For stricter data checking see \code{\link{check_data3}}.
#'
#' @inheritParams check_data_frame
#' @inheritParams check_rows
#' @inheritParams check_values
#' @inheritParams check_key
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_data2 <- function(data, values = NULL, min_row = 1, max_row = max_nrow(),
                       key = character(0), data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  data <- check_data_frame(data, data_name = data_name)
  data <- check_rows(data, min_row = min_row, max_row = max_row, data_name = data_name)
  data <- check_values(data, values = values, unique = TRUE, nulls = FALSE, data_name = data_name)
  data <- check_key(data, key = key, data_name = data_name)
  invisible(data)
}
