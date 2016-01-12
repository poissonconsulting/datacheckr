context("check-join")

test_that("check_join checks colnames", {
  x <- data.frame(y = 2)
  y <- data.frame(y = 2)
  expect_identical(check_join(x, y), x)
  expect_identical(check_join(x, y, "y"), x)

  y <- data.frame(y = 2, z = 3)
  expect_error(check_join(x, y, "z"), "colnames must be in x")
  y <- data.frame(y = 2, z = 3)
  expect_error(check_join(y, x, "z"), "colnames must be in x")

#  x <- data.frame(y = 1)
#  expect_error(check_join(x, y, "y"), "colnames must be in x")
})
