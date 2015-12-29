context("deck-data")

test_that("deck_data passes", {
  expect_true(deck_data(data.frame(A = 1, b = 2L)))
})

test_that("deck_data fails", {
  expect_error(deck_data(3, "w"), "w must be a data frame")
})
