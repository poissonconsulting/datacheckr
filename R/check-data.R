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
#' Checks a data frame based on a named
#' list of vectors that specifies the possible columns and their associated classes
#' and values.
#'
#' @param data The data frame to check.
#' @param values A named list specifying the columns and
#' their associated classes and values.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the original data frame.
#' @seealso \code{\link{datacheckr}}
#' @export
#' @examples
#' \dontrun{
#'
#' # if values is unspecified it simply checks that data is a data frame
#' check_data(1)
#' check_data(mtcars)
#'
#' # column names and classes are specified by
#' # the names and classes of the elements of values
#' check_data(mtcars, list(mpg = NULL))
#' check_data(mtcars, list(mpg = integer()))
#' check_data(mtcars, list(mpg = integer(), mpg = logical()))
#' check_data(mtcars, list(mpg = integer(),
#'                         mpg = logical(),
#'                         mpg = numeric()))
#' check_data(mtcars, list(mpg = numeric()))
#' check_data(mtcars, list(mpg = 2L))
#' check_data(mtcars, list(mpg = 35))
#'
#' # two non-missing values indicate a range
#' check_data(mtcars, list(mpg = c(20, 35)))
#' check_data(mtcars, list(mpg = c(10, 35)))
#' check_data(mtcars, list(mpg = c(10, 35), gear = c(3, 5)))
#'
#' # three or more non-missing values indicate specific values
#' check_data(mtcars, list(mpg = c(10, 35), gear = c(3, 5, 6)))
#' check_data(mtcars, list(mpg = c(10, 35), gear = c(3, 4, 5)))
#' # order is unimportant
#' check_data(mtcars, list(gear = c(4, 3, 5), mpg = c(35, 10)))
#'
#' # to permit missing values simply include an NA
#' # (with a non-missing value)
#' is.na(mtcars$gear[2]) <- TRUE
#' check_data(mtcars, list(gear = numeric()))
#' check_data(mtcars, list(gear = -3))
#' check_data(mtcars, list(gear = c(-3, NA)))
#' check_data(mtcars, list(gear = NA))
#' check_data(mtcars, list(gear = as.numeric(NA)))
#' }
check_data <- function(data, values = NULL) {
  substituted_data <- substitute(data)

  check_data_frame(data, substituted_data)
  if (!is.null(values)) {
    check_values(values)
    check_data_values(data, values, substituted_data)
  }
  invisible(data)
}
