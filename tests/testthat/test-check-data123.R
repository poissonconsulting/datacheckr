context("check-data123")

test_that("check_datas no rows", {
  x <- data.frame()

  expect_identical(check_data1(x), x)
  expect_identical(check_data1(x), x)
  expect_error(check_data2(x), "x must have at least 1 row")
  expect_error(check_data3(x), "x must have at least 1 row")
})

test_that("check_datas with NULLs in values", {
  x <- data.frame(Count = c(1,2))
  expect_error(check_data1(x, values = list(Count = NULL)),
               "x must not include column Count")

  expect_error(check_data2(x, values = list(Count = NULL)),
               "values cannot include NULLs")
  expect_error(check_data3(x, values = list(Count = NULL)),
               "values cannot include NULLs")
})

test_that("check_datas with multiple names in values", {
  x <- data.frame(Count = c(1,2))
  expect_identical(check_data1(x, values = list(Count = 1, Count = 1L)), x)

    expect_error(check_data2(x, values = list(Count = 1, Count = 1L)), "column names in values must be unique")
    expect_error(check_data3(x, values = list(Count = 1, Count = 1L)), "column names in values must be unique")
})

test_that("check_datas additional columns", {
  x <- data.frame(Count = c(1,2), Extra = 1L)
  expect_identical(check_data1(x, values = list(Count = 1)), x)
  expect_identical(check_data2(x, values = list(Count = 1)), x)
  expect_error(check_data3(x, values = list(Count = 1)), "column names in x must be identical to 'Count'")
  expect_identical(check_data3(x, values = list(Count = 1, Extra = 1L)), x)
  expect_error(check_data3(x, values = list(Extra = 1L, Count = 1)), "column names in x must be identical to 'Extra' and 'Count'")
  expect_identical(check_data3(x, values = list(Extra = 1L, Count = 1), select = TRUE),
                   subset(x, select = c("Extra", "Count")))
  expect_identical(check_data3(x, values = list(Count = 1), select = TRUE),
                   subset(x, select = "Count"))
})




