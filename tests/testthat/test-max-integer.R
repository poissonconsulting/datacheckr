context("max-integer")

test_that("max_integer works", {
  expect_true(length(max_integer()) == 1)
  expect_is(max_integer(), "integer")
  expect_identical(max_integer(), .Machine$integer.max)
})
