#' Check Length
#'
#' Checks length of an object is within bounds.
#'
#' @param x The object to check.
#' @param min_length A count of the minimum length.
#' @param max_length A count of the maximum length.
#' @param x_name A string of the name of the object.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the object.
#' @export
#' @examples
#' try(check_length(1:2, 3L))
check_length <- function(x, min_length = 1L, max_length = max_integer(), x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)

  check_count_internal(min_length)
  check_count_internal(max_length)

  if (max_length < min_length) error("max_length must not be less than min_length")

  if (length(x) < min_length)
    error(x_name, " must be at least of length ", min_length)

  if (length(x) > max_length)
    error(x_name, " must not be longer than ", max_length)
  invisible(x)
}
