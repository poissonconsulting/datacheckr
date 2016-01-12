context("max-nrow")

test_that("max_nrow works", {
  expect_true(length(max_nrow()) == 1)
  expect_is(max_nrow(), "integer")
  expect_identical(max_nrow(), as.integer(2 ^ 31 - 1))
})
