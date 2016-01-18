check_values_values <- function(values, unique, nulls) {
  check_flag_internal(unique)
  check_flag_internal(nulls)

  if (is.null(values)) return(invisible(values))

  if (!is.list(values)) error("values must be a list")
  if (!is_named(values)) error("values must be a named list")

  if (unique && anyDuplicated(names(values)))
    error("column names in values must be unique")

  if (!nulls && any(vapply(values, is.null, logical(1))))
    error("values cannot include NULLs")

  implemented <- vapply(values, inherits, logical(1), classes())
  if (any(!implemented))
    error("values must be a named list of vectors of class ",
               punctuate(classes()))

  classes <- get_classes(values)
  if (anyDuplicated(paste(names(values), classes)))
    error("values cannot have multiple vectors with the same name and class")
  invisible(values)
}
