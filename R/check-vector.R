#' Check Vector
#'
#' Checks the class and values of a vector
#'
#' @param vector The vector to check.
#' @param value A vector specifying the class and values.
#' @param min_length A count of the minimum length.
#' @param min_length A count of the maximum length.
#' @param vector_name A string of the name of vector.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the vector.
#' @seealso \code{\link{datacheckr}}
#' @export
check_vector <- function(vector, value, min_length = 1, max_length = max_nrow(),
                         vector_name = substitute(vector)) {
  if (!is.character(vector_name)) vector_name <- deparse(vector_name)
  check_string(vector_name)

  if (!is_vector(vector)) check_stop(vector_name, " must be a vector")
  if (!is_vector(value)) check_stop("value must be a vector")
  check_count(min_length)
  check_count(max_length)
  if (max_length < min_length) check_stop("max_length must not be less than min_length")

  if (length(vector) < min_length)
    check_stop(vector_name, " must be at least of length ", min_length)

  if (length(vector) > max_length)
    check_stop(vector_name, " must not be longer than ", max_length)

  classes <- get_classes(list(value))
  if (!inherits(vector, classes))
    check_stop(vector_name, " must be of class ", punctuate(classes))

  value <- check_vector_value_missing(vector, value, column_name = vector_name)
  if (length(value) == 1) return(invisible(vector))
  check_vector_value(vector, value, column_name = vector_name)
  invisible(vector)
}
