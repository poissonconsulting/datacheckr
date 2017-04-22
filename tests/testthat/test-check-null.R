context("check-check-null")

test_that("check_null", {
  expect_null(check_null(NULL))
  expect_error(check_null(1), "^1 must be NULL$")
})
