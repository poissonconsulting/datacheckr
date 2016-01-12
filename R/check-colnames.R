check_colnames <- function(data, colnames, exclusive, ordered, data_name) {
  colname_name <- substitute(colnames)

  if (is.null(colnames)) invisible(data)

  if (!is_flag(exclusive)) check_stop("exclusive must be a flag")
  if (!is_flag(ordered)) check_stop("ordered must be a flag")

  if (!(is.character(colnames) || is.factor(colnames)))
    check_stop("colnames must be a character vector")

  if (anyDuplicated(colnames)) check_stop("colnames must be unique")

  colnames <- as.character(colnames)
  data_colnames <- colnames(data)

  if (!ordered) {
    colnames <- sort(colnames)
    data_colnames <- sort(colnames)
  }
  if (!exclusive) data_colnames <- data_colnames[data_colnames %in% colnames]

  if (!equal(data_colnames, colnames))
    check_stop("column names in ", data_name, "do not match names in ", colname_name)
  invisible(data)
}
