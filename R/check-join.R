check_class_matches <- function(data, key, colnames, data_name, key_name) {
  if (!identical(lapply(data[colnames],class), lapply(key[colnames], class)))
     check_stop(data_name, " and ", key_name, "have columns with different classes")
    TRUE
}

check_extra_matches <- function(data, key, colnames, data_name, key_name) {
    extra <- setdiff(intersect(colnames(data), colnames(key)), colnames)
    if (length(extra))
      check_stop(data_name, " and ", key_name, "have additional columns with matching names")
    TRUE
}

check_referential_integrity <- function(data, key, data_name, key_name) {
  data$thaoeduotaehduaoteuhdaoetudtaohedu <- TRUE
  data <- merge(data, key, all.x = TRUE)
  if (any(is.na(data$thaoeduotaehduaoteuhdaoetudtaohedu)))
    check_stop("many-to-one join between ", data_name, " and ", key_name, " violates referential integrity")
  TRUE
}

#' Check Joins
#'
#' Checks that the columns in a data frame form a many-to-one
#' join with correponding columns in the key.
#'
#' @param data The data frame to check.
#' @param key A data.frame representing the key.
#' @param colnames A character vector specifying the columns of the key.
#' @param data_name A string of the name of data.
#' @param key_name A string of the name of key.
#'
#' @return Throws an informative error or returns an invisible copy of
#' the original data frame.
#' @seealso \code{\link{datacheckr}}
#' @export
check_join <- function(data, key, colnames = NULL, data_name = substitute(data),
                       key_name = substitute(key)) {
  data_name <- as.character(data_name)
  key_name <- as.character(key_name)

  if (!is_string(data_name)) check_stop("data_name must be a string")
  if (!is_string(key_name)) check_stop("key_name must be a string")

  check_data_frame(data, data_name)
  check_key(key, colnames = colnames, data_name = key_name)
  if (is.null(colnames)) colnames <- colnames(key)
  check_colnames(data, data_name, colnames)
  check_extra_matches(data, key, colnames, data_name, key_name)
  check_class_matches(data, key, colnames, data_name, key_name)
  check_referential_integrity(data, key, data_name, key_name)
  invisible(data)
}
