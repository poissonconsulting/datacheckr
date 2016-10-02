#' Check Unique
#'
#' Checks whether an object in unique (i.e. doesn't contain any duplicated elements).
#'
#'
#' @param x The object to check.
#' @param x_name A string of the name of the object.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the object.
#' @seealso \code{\link{datacheckr}}
#' @export
check_unique <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  if (anyDuplicated(x)) error(x_name, " must be unique")
  invisible(x)
}
