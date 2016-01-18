check_colnames <- function(data, colnames, exclusive, ordered, data_name) {
  colname_name <- substitute(colnames)

  if (is.null(colnames)) {
    if (!length(colnames(data)))
       error(data_name, " must include at least one column")
    return(invisible(data))
  }

  check_flag_internal(exclusive)
  check_flag_internal(ordered)

  if (!(is.character(colnames) || is.factor(colnames)))
    error("colnames must be a character vector")

  if (anyDuplicated(colnames)) error("colnames must be unique")

  colnames <- as.character(colnames)
  data_colnames <- colnames(data)

  if (exclusive) {
    if (ordered) {
      if (!equal(data_colnames, colnames))
        error("column names in ", data_name, " must be identical to ", punctuate(colnames, "and"))
    } else {
      if (!equal(sort(data_colnames), sort(colnames)))
        error("column names in ", data_name, " must include and only include ", punctuate(colnames, "and"))
    }
  } else {
    data_colnames <- data_colnames[data_colnames %in% colnames]
    if (ordered) {
      if (!equal(data_colnames, colnames))
        error("column names in ", data_name, " must include in the following order ", punctuate(colnames, "and"))
    } else {
      if (!equal(sort(data_colnames), sort(colnames)))
        error("column names in ", data_name, " must include ", punctuate(colnames, "and"))
    }
  }
  invisible(data)
}
