#' Check Data3
#'
#' Checks a data frame's rows, columns, classes and values and key.
#'
#' \code{check_data3} enforces maximal constraints.
#' By default it requires data to have rows (and therefore columns).
#' It also does not allow NULLs in values and
#' requires column names in values to be unique.
#' In addition it also requires that data only includes the columns in values in
#' the same order.
#'
#' For more permissive data checking see \code{\link{check_data}} and
#' \code{\link{check_data2}}.
#'
#' @inheritParams check_data_frame
#' @inheritParams check_rows
#' @inheritParams check_values
#' @inheritParams check_key
#' @param select A flag indicating whether to if possible
#' drop unnamed columns and reorder the remainder
#' so that column names matches those in values.
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_data3 <- function(data, values = NULL, min_row = 1, max_row = max_nrow(),
                        key = character(0), select = FALSE, data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)
  check_flag_internal(select)

  data <- check_data_frame(data, data_name = data_name)
  data <- check_rows(data, min_row = min_row, max_row = max_row, data_name = data_name)
  data <- check_values(data, values = values, unique = TRUE, nulls = FALSE, data_name = data_name)
  data <- check_cols(data, colnames = names(values),
                     exclusive = !select, ordered = !select, data_name = data_name)
  if (select)
    data <- subset(data, select = names(values))
  data <- check_key(data, key = key, data_name = data_name)
  invisible(data)
}
