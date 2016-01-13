check_class_matches <- function(data, parent, key, data_name, parent_name) {
  if (!identical(lapply(data[key], class), lapply(parent[key], class)))
     check_stop("columns in ", data_name, " and ", parent_name, " must have identical classes")
  invisible(data)
}

check_referential_integrity <- function(data, parent, key, data_name, parent_name) {
  if ("datacheckr_reserved_column_name" %in% colnames(data) || "datacheckr_reserved_column_name" %in% colnames(data))
    check_stop("the column name 'datacheckr_reserved_column_name' is reserved!")
  parent$datacheckr_reserved_column_name <- TRUE
  merged <- merge(data, parent, by = key, all.x = TRUE)
  if (any(is.na(merged$datacheckr_reserved_column_name)))
    check_stop("many-to-one join between ", data_name, " and ", parent_name, " violates referential integrity")
  invisible(data)
}

#' Check Join
#'
#' Checks that the columns in a data frame form a many-to-one
#' join with correponding columns in parent.
#'
#' By default (\code{key = NULL}) all the columns in parent represent the key.
#'
#' @inheritParams check_data_frame
#' @param parent A data frame of the parent table.
#' @param key A character vector of the key columns.
#' @param referential A flag indicating whether to check for referential integrity.
#' @param extra A flag indicating whether to allow additional matching columns.
#' @param parent_name A string of the name of parent.
#'
#' @return Throws an informative error or returns an invisible copy of
#' data.
#' @seealso \code{\link{datacheckr}}
#' @export
check_join <- function(data, parent, key = NULL, referential = TRUE,
                       extra = FALSE,
                       data_name = substitute(data),
                       parent_name = substitute(parent)) {
  data_name <- as.character(data_name)
  parent_name <- as.character(parent_name)

  check_flag(referential)
  check_flag(extra)
  check_string(data_name)
  check_string(parent_name)

  data <- check_data_frame(data, data_name)
  parent <- check_data_frame(parent, parent_name)

  matches <- intersect(colnames(data), colnames(parent))

  if (!length(matches)) {
    if (!equal(key, character(0)))
      check_stop(data_name, " and  ", parent_name, " must have matching columns")
    return(invisible(data))
  }
  if (is.null(key)) key <- matches
  parent <- check_key(parent, key = key, data_name = parent_name)
  data <- check_cols(data, colnames = key, exclusive = FALSE, ordered = FALSE,
                     data_name = data_name)
  if (!extra && length(setdiff(matches, key)))
    check_stop(data_name, " and ", parent_name, " must not have additional matching columns")
  data <- check_class_matches(data, parent, key, data_name, parent_name)
  if (referential)
    data <- check_referential_integrity(data, parent, key, data_name, parent_name)
  invisible(data)
}
