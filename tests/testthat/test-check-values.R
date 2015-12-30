context("check-values")

test_that("check_values passes", {
  expect_true(check_values(list(col1 = NULL)))
  expect_true(check_values(list(col1 = "x")))
  expect_true(check_values(list(col1 = "x", col1 = 1, col2 = integer())))
})

test_that("check_values fails", {
  expect_error(check_values(1), "values must be a list")
  expect_error(check_values(list(1)), "values must be a named list")
  expect_error(check_values(list(a = as.POSIXlt(Sys.time()))), "values must be a named list of vectors of class 'NULL', 'logical', 'integer', 'numeric', 'character', 'factor', 'Date' or 'POSIXct'")
  expect_error(check_values(list(Count = 1L, Count = 2L)),
               "values cannot have multiple vectors with the same name and class")
})
