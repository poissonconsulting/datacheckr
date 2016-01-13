check_colnames <- function(data, colnames, exclusive, ordered, data_name) {
  colname_name <- substitute(colnames)

  if (is.null(colnames)) {
    if (!length(colnames(data)))
       check_stop(data_name, " must include at least one column")
    return(invisible(data))
  }

  check_flag(exclusive)
  check_flag(ordered)

  if (!(is.character(colnames) || is.factor(colnames)))
    check_stop("colnames must be a character vector")

  if (anyDuplicated(colnames)) check_stop("colnames must be unique")

  colnames <- as.character(colnames)
  data_colnames <- colnames(data)

  if (exclusive) {
    if (ordered) {
      if (!equal(data_colnames, colnames))
        check_stop("column names in ", data_name, " must be identical to ", punctuate(colnames, "and"))
    } else {
      if (!equal(sort(data_colnames), sort(colnames)))
        check_stop("column names in ", data_name, " must include and only include ", punctuate(colnames, "and"))
    }
  } else {
    data_colnames <- data_colnames[data_colnames %in% colnames]
    if (ordered) {
      if (!equal(data_colnames, colnames))
        check_stop("column names in ", data_name, " must include in the following order ", punctuate(colnames, "and"))
    } else {
      if (!equal(sort(data_colnames), sort(colnames)))
        check_stop("column names in ", data_name, " must include ", punctuate(colnames, "and"))
    }
  }
  invisible(data)
}
