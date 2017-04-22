try_check <- function(expr) {
  try <- try(eval(expr), silent = TRUE)
  try
}

try_message <- function(x) {
  x <- as.character(x)
  x <- sub("^Error.*[:] ", "", x, perl = TRUE)
  x <- sub("\n$", "", x, perl = TRUE)
  x
}

#' Multiple Checks
#'
#' Checks that one or more checks return without an error.
#' Otherwise throws an error consisting of the error messages separated by OR.
#'
#' @param ... Checks to check.
#' @return Throws an informative error or returns an invisible TRUE.
#' @export
checkor <- function(...) {
#  .NotYetImplemented()
  args <- substitute(list(...))
  args <- args[-1]
  args <- lapply(args, try_check)
  args <- args[vapply(args, is.try_error, TRUE)]
  if(!length(args)) return(invisible(TRUE))
  args <- lapply(args, try_message)
  args <- unlist(args)
  args <- args[!duplicated(args)]
  args <- paste(args, collapse = " OR ")
  error(args)
}
