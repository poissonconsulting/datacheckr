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

  data <- data.frame(Count = c(0L,3L,2L,10L), LocationX = c(2000, NA, 2345, 1012))
  expect_identical(data, deck(data))
  expect_identical(data, deck(data, values))

  data <- data.frame(Count = c(0L,3L,2L,10L), Location = c(2000, NA, 2345, 1012))
  expect_identical(data, deck(data))
  expect_identical(data, deck(data, values))
  expect_identical(data, deck(data, values = list(Count = integer())))

  expect_error(deck(data, values = list(Count = NULL)),
               "data must not include column Count")

  expect_error(deck(data, values = list(Count = 1L, Count = 2L)),
               "values cannot have multiple vectors with the same name and class")

  expect_error(deck(data, values = list(Count = 1)),
               "column Count in data must be of class 'numeric'")

  expect_error(deck(data, values = list(Count = 1, Count = TRUE)),
               "column Count in data must be of class 'numeric' or 'logical'")

  data <- data.frame(Count = rep(NA, 3))
  expect_identical(data, deck(data, values = list(Count = NA)))

  data <- data.frame(Count = as.integer(rep(NA, 3)))
  expect_identical(data, deck(data, values = list(Count = as.integer(NA))))

  expect_error(deck(data, values = list(Count = NA)), "column Count in data must be of class 'logical'")

  data <- data.frame(Count = c(NA, NA))
  expect_identical(data, deck(data, values = list(Count = NA)))

  data <- data.frame(Count = c(TRUE, NA))
  expect_error(deck(data, values = list(Count = NA)), "column Count in data can only include missing values")

  data <- data.frame(Count = NA)
  expect_error(deck(data, values = list(Count = TRUE)), "column Count in data cannot include missing values")

  data <- data.frame(Count = 1)
  expect_error(deck(data, values = list(Count = c(4, 1.01))), "the values in column Count in data must lie between 1.01 and 4")

    data <- data.frame(Count = 2)
  expect_identical(deck(data, values = list(Count = c(4, 1.01))), data)

    data <- data.frame(Count = TRUE)
  expect_identical(deck(data, values = list(Count = c(TRUE, TRUE))), data)

      data <- data.frame(Count = TRUE)
  expect_identical(deck(data, values = list(Count = c(TRUE, FALSE))), data)

      data <- data.frame(Count = TRUE)
  expect_error(deck(data, values = list(Count = c(FALSE, FALSE))), "column Count in data can only include FALSE values")

  #    expect_error(deck(data, values = list(Count = NA)), "column Count in data must be of class 'logical'")
})

test_that("deck works with Dates", {
    data <- data.frame(Date1 = as.Date("2000-01-01"))

    values <- list(Date1 = as.Date(c("2000-01-01", "2000-01-03")))
    expect_identical(deck(data, values), data)
    values <- list(Date1 = as.Date(c("1999-01-01", "2000-01-03")))
    expect_identical(deck(data, values), data)
    values <- list(Date1 = as.Date(c("1999-01-01", "2000-01-03", "2000-02-01")))
    expect_error(deck(data, values), "column Date1 in data includes non-permitted values")
    values <- list(Date1 = as.Date(c("1999-01-01", "2000-01-03", "2000-01-03")))
    expect_error(deck(data, values), "column Date1 in data includes non-permitted values")
    values <- list(Date1 = as.Date(c("2000-01-03", "2000-01-03", "2000-01-03")))
    expect_error(deck(data, values), "column Date1 in data includes non-permitted values")
})
