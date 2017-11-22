#' Multiple Checks
#'
#' Checks that one or more checks return without an error.
#' Otherwise throws an error consisting of the error messages separated by OR.
#'
#' @param ... Checks to check.
#' @return Throws an informative error or returns an invisible TRUE.
#' @export
checkor <- function(...) {
  args <- substitute(list(...))
  args <- args[-1]
  n <- length(args)
  if (identical(n, 0L)) return(invisible(TRUE))
  args <- lapply(args, try_check)
  args <- args[vapply(args, is.try_error, TRUE)]
  if (!identical(length(args), n)) return(invisible(TRUE))
  args <- lapply(args, try_message)
  args <- unlist(args)
  args <- args[!duplicated(args)]
  args <- paste(args, collapse = " OR ")
  error(args)
}
