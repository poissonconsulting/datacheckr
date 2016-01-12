#' Check Key
#'
#' Checks that columns in a data frame represent a unique key.
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
  data_name <- as.character(data_name)
  data <- check_data_frame(data, data_name)
  data <- check_colnames(data, colnames = key, exclusive = FALSE,
                         ordered = FALSE, data_name = data_name)
  if (is.null(key)) return(invisible(data))

  key <- as.character(key)
  if (anyDuplicated(data[key])) {
    if (length(key) <= 5) {
      check_stop(plural("column", length(key), " "),
                 punctuate(colnames, "and"), " in ", data_name, " must be a unique key")
    }
    check_stop("columns key in ", data_name, "must be a unique key")
  }
  invisible(data)
}
