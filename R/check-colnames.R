check_colnames <- function(data, data_name, colnames) {
  if (!(is.character(colnames) | is.factor(colnames)))
    check_stop("colnames must be a character vector")
  if (!length(colnames))
    check_stop("colnames must a non-zero length character vector")
  if (anyDuplicated(colnames))
    check_stop("colnames must be unique")
  if (!any(colnames %in% colnames(data)))
    check_stop("colnames must be in ", data_name)
  TRUE
}
