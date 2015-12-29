context("deck-data")

test_that("deck_data passes", {
  expect_true(deck_data(data.frame(A = 1, b = 2L), "w"))
})

test_that("deck_data fails", {
  expect_error(deck_data(3, "w"), "w must be a data frame")
  data <- data.frame("A" = 1, "b" = 2L, "c" = 4L)
  colnames(data) <- c("A", "b", "A")
  expect_error(deck_data(data, "w"),
               "w must be a data frame with unique column names")
})
