context("check-key")

test_that("check_key checks colnames", {
  x <- data.frame(y = 2)
  expect_identical(check_key(x), x)
  expect_identical(check_key(x, "y"), x)
  expect_identical(check_key(x, factor("y")), x)
  expect_error(check_key(x, 1), "colnames must be a character vector")
  expect_identical(check_key(x, character()), x)
})

test_that("check_key works no rows", {
  x <- data.frame(y = 2)
  x <- x[FALSE, ,drop = FALSE]
  expect_identical(check_key(x), x)
})

test_that("check_key checks unique", {
  x <- data.frame(y = c(2,2))
  expect_error(check_key(x), "column 'y' in x must be a unique key")
  x <- data.frame(y = c(2,2), z = c(1,2))
  expect_identical(check_key(x), x)
  expect_error(check_key(x, "y"), "column 'y' in x must be a unique key")
  expect_identical(check_key(x, c("z")), x)
  expect_identical(check_key(x, c("y", "z")), x)
})

test_that("check_key checks unique with missing values", {
  x <- data.frame(y = c(2, 2))
  expect_error(check_key(x), "column 'y' in x must be a unique key")
  x <- data.frame(y = c(2, NA))
  expect_identical(check_key(x), x)
  x <- data.frame(y = c(2, NA), z = c(NA,2))
  expect_identical(check_key(x), x)
  x <- data.frame(y = c(NA))
  expect_identical(check_key(x), x)
  x1 <- data.frame(y = c(NA, NA))
  expect_error(check_key(x1), "column 'y' in x1 must be a unique key")
  x1 <- data.frame(y = c(NA, NA), z = c(NA, 1))
  expect_identical(check_key(x1), x1)
})

test_that("check_key works character(0)", {
  x <- data.frame(y = c(2,2))
  expect_error(check_key(x), "column 'y' in x must be a unique key")
  expect_identical(check_key(x, character(0)), x)
})

test_that("check_key works nas", {
  x <- data.frame(y = c(NA,NA))
  expect_error(check_key(x), "column 'y' in x must be a unique key")
  expect_identical(check_key(x, character(0)), x)
})
