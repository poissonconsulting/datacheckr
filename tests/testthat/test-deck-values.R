context("deck-values")

test_that("deck_values passes", {
  expect_true(deck_values(list(col1 = NULL)))
  expect_true(deck_values(list(col1 = "x")))
})

test_that("deck_values fails", {
  expect_error(deck_values(1, "w"), "w must be a list")
  expect_error(deck_values(list(1), "w"), "w must be a named list")
  expect_error(deck_values(list(a = Sys.time()), "w"), "w must be a named list of vectors of class 'NULL', 'logical', 'integer', 'numeric', 'character', 'factor' or 'Date'")
})
