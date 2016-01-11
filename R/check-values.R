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
