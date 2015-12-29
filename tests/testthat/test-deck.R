context("deck")

test_that("deck does nothing with NULL values", {
  x <- data.frame(y = 2)
  expect_identical(x, deck(x))
})

test_that("deck substitutes names correctly", {
  wrapper_function <- function(z) deck(z)
  expect_error(wrapper_function(z = 3), "z must be a data frame")
  expect_error(wrapper_function(3), "z must be a data frame")
})
