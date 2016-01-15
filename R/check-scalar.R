#' Check Scalar
#'
#' Checks the class and values of a scalar
#'
#' @param vector The vector to check.
#' @param value A vector specifying the class and values.
#' @param key A flag indicating whether the values must be unique.
#' @param data_name A string of the name of vector.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the vector.
#' @seealso \code{\link{datacheckr}}
#' @export
check_scalar <- function(scalar, value, scalar_name = substitute(scalar)) {
  if (!is.character(vector_name)) vector_name <- deparse(vector_name)
  check_string(vector_name)

  if (!is_vector(vector)) check_stop(vector_name, " must be a vector")
  if (!is_vector(value)) check_stop("value must be a vector")
  check_flag(key)

  classes <- get_classes(list(value))
  if (!inherits(vector, classes))
    check_stop(vector_name, " must be of class ", punctuate(classes))

  value <- check_vector_value_missing(vector, value, column_name = vector_name)
  if (length(value) == 1) return(invisible(vector))
  check_vector_value(vector, value, column_name = vector_name)
  invisible(vector)
}
