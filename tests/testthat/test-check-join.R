context("check-join")

test_that("check_join checks colnames", {
  x <- data.frame(y = 2)
  y <- data.frame(y = 2)
  expect_identical(check_join(x, y), x)
  expect_identical(check_join(x, y, "y"), x)

  y <- data.frame(y = 2, z = 3)
  expect_error(check_join(x, y, "z"), "column names in x must include 'z'")
  x <- data.frame(y = 2, z = 3)
  expect_error(check_join(y, x, "z"), "y and x must not have additional matching columns")
  expect_identical(check_join(y, x, "z", extra = TRUE), y)
  expect_identical(check_join(y, x, c("z", "y")), y)

  y <- data.frame(y = c(1,2,3,4))
  x <- data.frame(y = c(1,2,4,2))
  expect_identical(check_join(x, y), x)
  expect_error(check_join(y, x), "column 'y' in x must be a unique key")

  y$y <- as.integer(y$y)
  expect_error(check_join(y, x), "column 'y' in x must be a unique key")
  expect_error(check_join(x, y), "columns in x and y must have identical classes")

  y <- data.frame(y = c(1,2,3,4))
  x <- data.frame(y = c(1,2,4,2,5))
  expect_error(check_join(x, y), "many-to-one join between x and y violates referential integrity")
  expect_identical(check_join(x, y, referential = FALSE), x)

  y <- data.frame(y = c(1,NA,3,4))
  x <- data.frame(y = c(1,NA,4,NA))
  expect_identical(check_join(x, y), x)
  expect_error(check_join(y, x), "column 'y' in x must be a unique key")
})

test_that("check_join checks colnames diff names", {
  x <- data.frame(x = 2)
  y <- data.frame(y = 2)
  expect_error(check_join(x, y), "x and y must have matching columns")
  expect_error(check_join(x, y, "y"), "column names in x must include 'y'")
  expect_error(check_join(x, y, "x"), "column names in y must include 'x'")
  expect_identical(check_join(x, y, c("x" = "y")), x)
  expect_error(check_join(x, y, c("y" = "x")), "column names in x must include 'y'")
})

test_that("check_join missing values", {
  x <- data.frame(x = c(NA, 2))
  y <- data.frame(x = 2)
  expect_error(check_join(x, y), "many-to-one join between x and y violates referential integrity")
  expect_identical(check_join(x, y, ignore_nas = TRUE), x)
  y <- data.frame(x = c(2, NA))
  expect_identical(check_join(x, y), x)
  expect_identical(check_join(x, y, ignore_nas = TRUE), x)
  x <- data.frame(x = c(NA, 2, NA))
  expect_identical(check_join(x, y), x)
  x <- data.frame(x = as.numeric(c(NA, NA)))
  expect_identical(check_join(x, y), x)
  expect_identical(check_join(x, y, ignore_nas = TRUE), x)
})

