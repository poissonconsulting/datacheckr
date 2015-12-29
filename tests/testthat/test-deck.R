context("deck")

test_that("deck does nothing with NULL values", {
  x <- data.frame(y = 2)
  expect_identical(x, deck(x))
})

test_that("deck does nothing with NULL values", {
  x <- data.frame(y = 2)
  expect_identical(x, deck(x))
})

test_that("deck substitutes names correctly", {
  wrapper_function <- function(z) deck(z)
  expect_error(wrapper_function(z = 3), "z must be a data frame")
  expect_error(wrapper_function(3), "z must be a data frame")
})

test_that("deck works", {
  values <- list("Count" = c(0L, .Machine$integer.max),
                 "Comments" = NULL,
                 "LocationX" = c(NA, 2345, 1012),
                 "LocationX" = NULL)

  data <- data.frame(Count = c(0,3,2,10), Location = c(2000, NA, 2345, 1012))
  expect_identical(data, deck(data))
  expect_identical(data, deck(data, values))

  expect_error(deck(data, values = list(Count = NULL)),
               "data must not include column Count")

  expect_error(deck(data, values = list(Count = 1L, Count = 2L)),
               "values cannot have multiple vectors with the same name and class")

})

