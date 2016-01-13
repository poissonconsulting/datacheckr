context("check-cols")

test_that("check_cols requires a data frame", {
  x <- data.frame(y = 2)
  expect_identical(check_cols(x), x)
  y <- NULL
  expect_error(check_cols(y), "y must be a data frame")
})

test_that("check_cols matches colnames", {
  x <- data.frame(y = 2)
  expect_identical(check_cols(x, "y"), x)
  expect_error(check_cols(x, "z"), "column names in x must include 'z'")
  expect_error(check_cols(x, "z", exclusive = TRUE), "column names in x must include and only include 'z'")
  expect_error(check_cols(x, "z", ordered = TRUE), "column names in x must include in the following order 'z'")
  expect_error(check_cols(x, "z", exclusive = TRUE, ordered = TRUE), "column names in x must be identical to 'z'")

  x <- data.frame(y = 2, z = 3)
  expect_identical(check_cols(x, "y"), x)
  expect_identical(check_cols(x, "z"), x)
  expect_identical(check_cols(x, c("y", "z")), x)
  expect_identical(check_cols(x, c("z", "y")), x)
  expect_error(check_cols(x, c("z", "a")), "column names in x must include 'z' and 'a'")
  expect_error(check_cols(x, c("z", "y"), ordered = TRUE), "column names in x must include in the following order 'z' and 'y'")
  expect_error(check_cols(x, "z", exclusive = TRUE), "column names in x must include and only include 'z'")
})

test_that("check_cols requires a column", {
  x <- data.frame()
  expect_identical(check_cols(x, character(0)), x)
  expect_error(check_cols(x), "x must include at least one column")
  expect_error(check_cols(x, "e"), "column names in x must include 'e'")
})
