#' Check Scalar
#'
#' Checks the class and values of a scalar
#'
#' @param scalar The scalar to check.
#' @param value A vector specifying the class and value.
#' @param scalar_name A string of the name of vector.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the scalar.
#' @seealso \code{\link{datacheckr}}
#' @export
check_scalar <- function(scalar, value, scalar_name = substitute(scalar)) {
  if (!is.character(scalar_name)) scalar_name <- deparse(scalar_name)
  check_string(scalar_name)

  if (!is_scalar(scalar)) check_stop(scalar_name, " must be a scalar")
  check_vector(scalar, value, min_length = 1, max_length = 1, vector_name = scalar_name)
}
