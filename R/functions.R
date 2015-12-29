deck_stop <- function(...) stop(..., call. = FALSE)
is_named <- function(x) !is.null(names(x))

punctuate <- function(x, qualifier = "or", speech = "'") {
  x <- paste0(speech, x, speech)
  if (length(x) == 1)
    return(x)
  n <- length(x)
  paste(paste(x[-n], collapse = ", "), qualifier, x[n])
}

classes <- function() {
  c("NULL", "logical", "integer", "numeric", "character", "factor", "Date")
}

get_class <- function(x) {
  logical_vector <- inherits(x, classes(), which = TRUE) == 1
  classes()[logical_vector]
}

get_classes <- function(values) {
  vapply(values, get_class, character(1))
}

deck_data <- function(data, substituted_data) {
  if (!is.data.frame(data)) deck_stop(substituted_data, " must be a data frame")
  if (anyDuplicated(colnames(data)))
    deck_stop(substituted_data, " must be a data frame with unique column names")
  TRUE
}

deck_values <- function(values) {
  if (!is.list(values)) deck_stop("values must be a list")
  if (!is_named(values)) deck_stop("values must be a named list")
  implemented <- vapply(values, inherits, logical(1), classes())
  if (any(!implemented))
    deck_stop("values must be a named list of vectors of class ",
              punctuate(classes()))

  classes <- get_classes(values)
  if (anyDuplicated(paste(names(values), classes)))
    deck_stop("values cannot have multiple vectors with the same name and class")
  TRUE
}

deck_vector_values_nulls <- function(vector, values, column_name, substituted_data) {
  nulls <- vapply(values, is.null, logical(1))
  if (all(nulls)) {
    if (!is.null(vector))
      deck_stop(substituted_data, " must not include column ", column_name)
    return(TRUE)
  }
  if (any(nulls) && is.null(vector))
    return(TRUE)
  values[!nulls]
}

deck_vector_values_class <- function(vector, values, column_name, substituted_data) {
  classes <- get_classes(values)

  logical_vector <- inherits(vector, classes, which = TRUE) == 1
  if (!any(logical_vector)) {
    deck_stop("column ", column_name, " in ", substituted_data, " must be of class ",
              punctuate(classes))
  }
  stopifnot(sum(logical_vector) == 1)
  values[[logical_vector]]
}

deck_vector_value_missing <- function(vector, value, column_name, substituted_data) {
  if (!length(value) || !length(vector))
    return(TRUE)
  missing <- any(is.na(value))
  value <- value[!is.na(value)]

  if (!missing && any(is.na(vector)))
    deck_stop("column ", column_name, " in ", substituted_data, " cannot include missing values")

  if (!length(value)) {
    if (!all(is.na(vector)))
      deck_stop("column ", column_name, " in ", substituted_data, " can only include missing values")
    return(TRUE)
  }
  value
}

deck_data_values_column <- function(column_name, data, values, substituted_data) {
  vector <- data[[column_name]]
  values <- values[names(values) == column_name]

  values <- deck_vector_values_nulls(vector, values, column_name, substituted_data)
  if (identical(values, TRUE)) return(TRUE)

  value <- deck_vector_values_class(vector, values, column_name, substituted_data)
  value <- deck_vector_value_missing(vector, value, column_name, substituted_data)
  if (length(value) == 1) return(TRUE)
  deck_vector_values(vector, value, column_name, substituted_data)
}

deck_data_values <- function(data, values, substituted_data) {
  column_names <- sort(unique(names(values)))
  sapply(column_names, FUN = deck_data_values_column, data = data, values = values,
         substituted_data = substituted_data)
  TRUE
}


#' Data Check
#'
#' The deck (short for data check) function takes a data frame data and a named
#' list values that specifies the columns in data and their associated values.
#' If data passes all the conditions set by values then deck returns the original
#' data frame (which allows the function to be inserted in piping chains).
#' Otherwise deck throws an informative error.
#'
#' If values is unspecified deck simply checks that data is a data frame.
#'
#' @param data The data frame to check.
#' @param values A named list specifying the columns and their associated values.
#'
#' @return Throws an informative error or returns the original data object.
#' @export
deck <- function(data, values = NULL) {
  substituted_data <- substitute(data)

  deck_data(data, substituted_data)
  if (!is.null(values)) {
    deck_values(values)
    deck_data_values(data, values, substituted_data)
  }
  data
}
