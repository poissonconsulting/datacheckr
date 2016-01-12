#' Check Data3
#'
#' Checks a data frame's rows columns, classes, values, and key.
#'
#' @inheritParams check_data_frame
#' @inheritParms check_rows
#' @inheritParms check_values
#' @inheritParams check_key
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_data3 <- function(data, values = NULL, min_row = 0, max_row = max_nrow(),
                       key = NULL, data_name = substitute(data)) {
  data_name <- as.character(data_name)
  data <- check_data_frame(data, data_name = data_name)
  data <- check_rows(data, min_row = min_row, max_row = max_row, data_name = data_name)
  data <- check_values(data, values = values, unique = TRUE, nulls = FALSE, data_name = data_name)
  data <- check_colnames(data, colnames = names(values), exclusive = TRUE, ordered = FALSE)
  data <- check_key(data, key = key, data_name = data_name)
  invisible(data)
}
