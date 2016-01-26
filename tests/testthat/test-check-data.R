context("check-data1")

test_that("check_data does nothing with NULL values", {
  x <- data.frame(y = 2)
  expect_identical(x, check_data1(x))
})

test_that("check_data works no rows", {
  x <- data.frame(y = 2)
  x <- x[FALSE,,drop = FALSE]
  expect_identical(x, check_data1(x))
  expect_identical(x, check_data1(x, list(y = 1)))
  expect_identical(x, check_data1(x, list(y = as.numeric(NA))))
  expect_identical(x, check_data1(x, list(y = c(1,NA))))
  expect_identical(x, check_data1(x, list(y = c(4,3))))
  expect_identical(x, check_data1(x, list(y = c(4,3,5))))
  expect_identical(x, check_data1(x, list(y = c(4,3,5, NA))))

  expect_error(check_data1(x, list(y = 1L)),
               "column y in x must be of class 'integer'")
  expect_error(check_data1(x, list(y = c(1L,2L))),
               "column y in x must be of class 'integer'")
})

test_that("check_data min_row and max_row", {
  x <- data.frame(y = c(2,4))

  expect_identical(x, check_data1(x))
  expect_identical(x, check_data1(x, min_row = 2, max_row = 2))
  expect_error(check_data1(x, min_row = 3), "x must have at least 3 rows")
  expect_error(check_data1(x, max_row = 1), "x must have no more than 1 row")

  expect_error(check_data1(x, min_row = -1), "min_row must be a count")
  expect_error(check_data1(x, min_row = ""), "min_row must be a count")

  expect_error(check_data1(x, max_row = -1), "max_row must be a count")
  expect_error(check_data1(x, max_row = ""), "max_row must be a count")
})

test_that("check_data requires data frame", {
  w <- 3
  expect_error(check_data1(w), "w must be a data frame")
})

test_that("check_data requires unique column names in data", {
  data <- data.frame("A" = 1, "b" = 2L, "c" = 4L)
  colnames(data) <- c("A", "b", "A")
  expect_error(check_data1(data),
               "data must have unique column names")
})

test_that("check_data substitutes names correctly", {
  wrapper_function <- function(z) check_data1(z)
  expect_error(wrapper_function(z = 3), "z must be a data frame")
  expect_error(wrapper_function(3), "z must be a data frame")
})

test_that("check_data tests for column names", {
  x <- data.frame(Count = c(1,2))
  expect_error(check_data1(x, values = list(Count = NULL)),
               "x must not include column Count")

  expect_identical(check_data1(x, values = list(Count = 3)), x)
  expect_identical(check_data1(x, values = list(Count = 3, Count = NULL)), x)

  y <- data.frame(Count2 = c(1,2))
  expect_identical(check_data1(y, values = list(Count = NULL)), y)
})

test_that("check_data tests for classes", {
  x <- data.frame(Count = 1L)

  expect_error(check_data1(x, values = list(Count = 1)),
               "column Count in x must be of class 'numeric'")
  expect_error(check_data1(x, values = list(Count = 1, Count = TRUE)),
               "column Count in x must be of class 'numeric' or 'logical'")
  expect_identical(check_data1(x, values = list(Count = 1, Count = integer())), x)
})

test_that("check_data tests for classes with and without unique", {
  x <- data.frame(Count = 1L)

  expect_error(check_data1(x, values = list(Count = 1)),
               "column Count in x must be of class 'numeric'")
  expect_error(check_data1(x, values = list(Count = 1)),
               "column Count in x must be of class 'numeric'")

  expect_error(check_data1(x, values = list(Count = 1, Count = TRUE)),
               "column Count in x must be of class 'numeric' or 'logical'")
  expect_identical(check_data1(x, values = list(Count = 1, Count = integer())), x)
})

test_that("check_data tests for missing values", {
  x <- data.frame(Count = c(1,2, NA))
  expect_error(check_data1(x, values = list(Count = 1)),
               "column Count in x cannot include missing values")
  expect_identical(check_data1(x, values = list(Count = numeric())), x)
  expect_identical(check_data1(x, values = list(Count = c(3,NA))), x)
  expect_error(check_data1(x, values = list(Count = as.numeric(NA))),
               "column Count in x can only include missing values")

  y <- data.frame(Count = c(1,2))
  expect_identical(check_data1(y, values = list(Count = 1)), y)
  expect_identical(check_data1(y, values = list(Count = numeric())), y)
  expect_identical(check_data1(y, values = list(Count = c(3,NA))), y)
  expect_error(check_data1(y, values = list(Count = as.numeric(NA))),
               "column Count in y can only include missing values")

  z <- data.frame(Count = as.numeric(NA))
  expect_error(check_data1(z, values = list(Count = 1)), "column Count in z cannot include missing values")
  expect_identical(check_data1(z, values = list(Count = numeric())), z)
  expect_identical(check_data1(z, values = list(Count = c(3,NA))), z)
  expect_identical(check_data1(z, values = list(Count = as.numeric(NA))), z)
})

test_that("check_data tests for range", {
  x <- data.frame(Count2 = 1)
  expect_error(check_data1(x, values = list(Count2 = c(4, 1.01))), "the values in column Count2 in x must lie between 1.01 and 4")

  y <- data.frame(Count2 = 2)
  expect_identical(check_data1(y, values = list(Count2 = c(4, 1.01))), y)
})

test_that("check_data tests for specific values", {
  x <- data.frame(Count2 = 1)
  expect_error(check_data1(x, values = list(Count2 = c(0, 4, 5))), "column Count2 in x must only include the permitted values 0, 4 and 5")
  expect_error(check_data1(x, values = list(Count2 = c(5, 5, 5))), "column Count2 in x must only include the permitted value 5")
  expect_error(check_data1(x, values = list(Count2 = c(0, 2, 3, 4, 5, 6))), "column Count2 in x includes non-permitted values")
  expect_identical(check_data1(x, values = list(Count2 = c(1, 4, 5))), x)
})

test_that("check_data works with logical vectors", {
  data <- data.frame(Count = TRUE)
  expect_identical(check_data1(data, values = list(Count = c(TRUE, TRUE))), data)

  data <- data.frame(Count = TRUE)
  expect_identical(check_data1(data, values = list(Count = c(TRUE, FALSE))), data)

  data <- data.frame(Count = TRUE)
  expect_error(check_data1(data, values = list(Count = c(FALSE, FALSE))), "column Count in data can only include FALSE values")
})

test_that("check_data works with Dates", {
  data <- data.frame(Date1 = as.Date("2000-01-01"))

  values <- list(Date1 = as.Date(c("2000-01-01", "2000-01-03")))
  expect_identical(check_data1(data, values), data)
  values <- list(Date1 = as.Date(c("1999-01-01", "2000-01-03")))
  expect_identical(check_data1(data, values), data)
  values <- list(Date1 = as.Date(c("1999-01-01", "2000-01-03", "2000-02-01")))
  expect_error(check_data1(data, values), "column Date1 in data must only include the permitted values '1999-01-01', '2000-01-03' and '2000-02-01'")
  values <- list(Date1 = as.Date(c("1999-01-01", "2000-01-03", "2000-01-03")))
  expect_error(check_data1(data, values), "column Date1 in data must only include the permitted values '1999-01-01' and '2000-01-03'")
  values <- list(Date1 = as.Date(c("2000-01-03", "2000-01-03", "2000-01-03")))
  expect_error(check_data1(data, values), "column Date1 in data must only include the permitted value '2000-01-03'")
})

test_that("check_data works with character", {
  x <- data.frame(c1 = "char", stringsAsFactors = FALSE)
  expect_identical(check_data1(x, values = list(c1 = character())), x)
  expect_identical(check_data1(x, values = list(c1 = "char2")), x)
  expect_error(check_data1(x, values = list(c1 = c("char2", "ee"))), "column c1 in x contains strings that do not match both regular expressions 'char2' and 'ee'")
  expect_error(check_data1(x, values = list(c1 = c("ee", "char"))), "column c1 in x contains strings that do not match both regular expressions 'char' and 'ee'")
  expect_identical(check_data1(x, values = list(c1 = c("char", "ch"))), x)
  expect_error(check_data1(x, values = list(c1 = c("ee", "eu", "oeu"))), "column c1 in x must only include values which match the regular expressions 'ee', 'eu' or 'oeu'")
  expect_identical(check_data1(x, values = list(c1 = c("oeu", "eu", "ch"))), x)
})

test_that("check_data works with factor", {
  x <- data.frame(z2 = "char", stringsAsFactors = TRUE)

  expect_identical(check_data1(x, values = list(z2 = factor())), x)
  expect_identical(check_data1(x, values = list(z2 = factor("x"))), x)
  expect_error(check_data1(x, values = list(z2 = factor(c("x", "char")))),
               "column z2 in x lacks factor levels 'char' and 'x'")

  x <- data.frame(z3 = ordered("char"))
  expect_identical(check_data1(x, values = list(z3 = factor())), x)

  x <- data.frame(z2 = c("char", "x"), stringsAsFactors = TRUE)
  expect_identical(check_data1(x, values = list(z2 = factor(c("x", "char")))), x)

  x$z3 <- factor(c("char", "x"), levels = c("x", "3", "char"))
  expect_identical(check_data1(x, values = list(z3 = factor(c("x", "char")))), x)

  x$z3 <- factor(c("char", "x1"), levels = c("x1", "3", "char"))
  expect_error(check_data1(x, values = list(z3 = factor(c("x", "char")))),
               "column z3 in x lacks factor levels 'char' and 'x'")

  expect_error(check_data1(x, values = list(z3 = factor(c("x1", "char", "3")))),
               "column z3 in x must be a factor with the levels '3', 'char' and 'x1'")

  expect_identical(check_data1(x, values = list(
    z3 = factor(c("x1", "char", "3"), levels = c("x1", "3", "char")))),
    x)

  expect_identical(check_data1(x, values = list(
    z3 = factor(c("x1", "x1", "x1"), levels = c("x1", "3", "char")))),
    x)
})

test_that("check_data works with POSIXct", {
  d <- data.frame(T2 = ISOdate(2000, 1, 1))

  expect_identical(check_data1(d, values = list(T2 = Sys.time())), d)
  expect_identical(check_data1(d, values = list(T2 = ISOdate(2000, 1, c(1,2)))), d)
  expect_identical(check_data1(d, values = list(T2 = ISOdate(2000, 1, c(1,2,3)))), d)

  d <- data.frame(T2 = ISOdate(2000, 1, 2))
  expect_identical(check_data1(d, values = list(T2 = ISOdate(2000, 1, c(1,3)))), d)
  expect_error(check_data1(d, values = list(T2 = ISOdate(2000, 1, c(3,4)))),
               "the values in column T2 in d must lie between 2000-01-03 12:00:00 and 2000-01-04 12:00:00")
  expect_error(check_data1(d, values = list(T2 = ISOdate(2000, 1, c(1, 3,4)))),
               "column T2 in d must only include the permitted values '2000-01-01 12:00:00', '2000-01-03 12:00:00' and '2000-01-04 12:00:00'")
})

test_that("check_data works", {
  values <- list("Count" = c(0L, .Machine$integer.max),
                 "Comments" = NULL,
                 "LocationX" = c(NA, 2345, 1012),
                 "LocationX" = NULL)

  data <- data.frame(Count = c(0L,3L,2L,10L), LocationX = c(2000, NA, 2345, 1012))
  expect_identical(data, check_data1(data))
  expect_identical(data, check_data1(data, values))

  data <- data.frame(Count = c(0L,3L,2L,10L), Location = c(2000, NA, 2345, 1012))
  expect_identical(data, check_data1(data))
  expect_identical(data, check_data1(data, values))
  expect_identical(data, check_data1(data, values = list(Count = integer())))
})

