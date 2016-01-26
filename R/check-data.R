#' Check Data1
#'
#' Checks a data frame's rows, columns, classes and values and key.
#'
#' \code{check_data1} enforces minimal contraints.
#' By default it does not require data to have any rows or columns.
#' It also allows NULLs in values and does not
#' require column names in values to be unique.
#'
#' For stricter data checking see \code{\link{check_data2}}
#' and \code{\link{check_data3}}.
#'
#' @inheritParams check_data_frame
#' @inheritParams check_rows
#' @inheritParams check_values
#' @inheritParams check_key
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @aliases check_data
#' @export
check_data1 <- function(data, values = NULL, min_row = 0, max_row = max_nrow(),
                        key = character(0), data_name = substitute(data)) {

  if (!is.character(data_name)) data_name <- deparse(data_name)
  data <- check_data_frame(data, data_name = data_name)
  data <- check_rows(data, min_row = min_row, max_row = max_row, data_name = data_name)
  data <- check_values(data, values = values, unique = FALSE, nulls = TRUE, data_name = data_name)
  data <- check_key(data, key = key, data_name = data_name)
  invisible(data)
}

#' @export
check_data <- function(data, values = NULL, min_row = 0, max_row = max_nrow(),
                       key = character(0), data_name = substitute(data)) {
  if (!is.character(data_name)) data_name <- deparse(data_name)

  .Deprecated("check_data1")
  check_data1(data = data, values = values, min_row = min_row, max_row = max_row,
              key = key, data_name = data_name)
}
