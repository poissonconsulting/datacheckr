context("check-number")

test_that("check_number errors", {
  y <- 2
  expect_identical(check_number(y), y)
  y <- 2L
  expect_error(check_number(y), "y must be of class 'numeric'")
  y <- 1:2
  expect_error(check_number(y), "y must be a scalar")
  y <- NULL
  expect_error(check_number(y), "y must be a scalar")
  expect_identical(check_number(-1), -1)
})
