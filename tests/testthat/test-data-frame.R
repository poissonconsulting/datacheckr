context("check-data-frame")

test_that("check_data_frame requires a data frame", {
  x <- data.frame(y = 2)
  expect_identical(check_data_frame(x), x)
  x <- 1
  expect_error(check_data_frame(x), "x must be a data frame")
  y <- NULL
  expect_error(check_data_frame(y), "y must be a data frame")
})


test_that("check_data_frame works no rows", {
  x <- data.frame(y = 2)
  expect_identical(check_data_frame(x), x)
  x <- x[FALSE,,drop = FALSE]
  expect_identical(check_data_frame(x), x)
})

test_that("check_data_frame requires unique column names in data", {
  z <- data.frame("A" = 1, "b" = 2L, "c" = 4L)
  colnames(z) <- c("A", "b", "A")
  expect_error(check_data1(z), "z must have unique column names")
})
