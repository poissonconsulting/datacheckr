context("check-flag")

test_that("check_flag errors", {
  y <- TRUE
  expect_identical(check_flag(y), y)
  y <- 2
  expect_error(check_flag(y), "y must be of class 'logical'")
  y <- c(TRUE, TRUE)
  expect_error(check_flag(y), "y must be a scalar")
  y <- NA
  expect_error(check_flag(y), "y cannot include missing values")
  expect_identical(check_flag(FALSE), FALSE)
})
