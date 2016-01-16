context("check-date")

test_that("check_date errors", {
  y <- as.Date("2000-02-02")
  expect_identical(check_date(y), y)
  y <- 2
  expect_error(check_date(y), "y must be of class 'Date'")
  y <- 1:2
  expect_error(check_date(y), "y must be a scalar")
  y <- NULL
  expect_error(check_date(y), "y must be a scalar")
  y <- c(as.Date("2000-02-02"), NA)
  expect_error(check_date(y), "y must be a scalar")
})
