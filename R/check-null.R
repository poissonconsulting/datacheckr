#' Check NULL
#'
#' Checks object is NULL.
#'
#' @param x The object to check.
#' @param x_name A string of the name of the object.
#' @return Throws an informative error or returns NULL.
#' @export
check_null <- function(x, x_name = substitute(x)) {
  if (!is.character(x_name)) x_name <- deparse(x_name)
  if (!is.null(x)) error(x_name, " must be NULL")
  invisible(x)
}
