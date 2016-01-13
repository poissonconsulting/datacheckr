context("check-rows")

test_that("check_rows requires a data frame", {
  x <- data.frame(y = 2)
  expect_identical(check_rows(x), x)
  y <- NULL
  expect_error(check_rows(y), "y must be a data frame")
})

test_that("check_rows requires counts", {
  x <- data.frame(y = 2)
  expect_identical(check_rows(x), x)
  expect_error(check_rows(x, min_row = -1), "min_row must be a count")
  expect_error(check_rows(x, min_row = 1.5), "min_row must be a count")
  expect_error(check_rows(x, min_row = 2, max_row = 1), "max_row must not be less than min_row")
})

test_that("check_rows checks rows", {
  x <- data.frame(y = 2)
  expect_identical(check_rows(x), x)
  expect_error(check_rows(x, min_row = 2), "x must have at least 2 rows")
  expect_error(check_rows(x, max_row = 0), "max_row must not be less than min_row")
  expect_error(check_rows(x, min_row = 0, max_row = 0), "x must have no more than 0 rows")
  x <- x[FALSE,,drop = FALSE]
  expect_identical(check_rows(x, min_row = 0), x)
  expect_error(check_rows(x), "x must have at least 1 row")
  expect_error(check_rows(x, min_row = 2), "x must have at least 2 rows")
})
