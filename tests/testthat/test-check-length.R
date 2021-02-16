test_that("check_length errors", {
  y <- 2L
  expect_identical(check_length(y), y)
  expect_error(check_length(y, 2L), "y must be at least of length 2")
})
