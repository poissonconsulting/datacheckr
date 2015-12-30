check_data_frame <- function(data, substituted_data) {
  if (!is.data.frame(data)) check_stop(substituted_data, " must be a data frame")
  if (anyDuplicated(colnames(data)))
    check_stop(substituted_data, " must be a data frame with unique column names")
  TRUE
}

check_values <- function(values) {
  if (!is.list(values)) check_stop("values must be a list")
  if (!is_named(values)) check_stop("values must be a named list")
  implemented <- vapply(values, inherits, logical(1), classes())
  if (any(!implemented))
    check_stop("values must be a named list of vectors of class ",
              punctuate(classes()))

  classes <- get_classes(values)
  if (anyDuplicated(paste(names(values), classes)))
    check_stop("values cannot have multiple vectors with the same name and class")
  TRUE
}

#' Check Data
#'
#' Checks data based on a named
#' list of vectors that specifies the possible columns and their associated classes
#' and values.
#' If data passes all the conditions set by values then data_check returns the original
#' data frame (which allows the function to be inserted in piping chains).
#' Otherwise data_check throws an informative error.
#'
#' If values is unspecified data_check simply checks that data is a data frame.
#' The regular expression checking of character strings is performed using
#' grepl with perl = TRUE.
#'
#' @param data The data frame to check.
#' @param values A named list specifying the columns and their associated values.
#'
#' @return Throws an informative error or returns the original data object.
#' @export
check_data <- function(data, values = NULL) {
  substituted_data <- substitute(data)

  check_data_frame(data, substituted_data)
  if (!is.null(values)) {
    check_values(values)
    check_data_values(data, values, substituted_data)
  }
  data
}
