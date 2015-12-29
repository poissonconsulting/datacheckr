context("deck-values")

test_that("deck_values passes", {
  expect_true(deck_values(list(col1 = NULL)))
  expect_true(deck_values(list(col1 = "x")))
  expect_true(deck_values(list(col1 = "x", col1 = 1, col2 = integer())))
})

test_that("deck_values fails", {
  expect_error(deck_values(1), "values must be a list")
  expect_error(deck_values(list(1)), "values must be a named list")
  expect_error(deck_values(list(a = Sys.time())), "values must be a named list of vectors of class 'NULL', 'logical', 'integer', 'numeric', 'character', 'factor' or 'Date'")
  expect_error(deck_values(list(Count = 1L, Count = 2L)),
               "values cannot have multiple vectors with the same name and class")
})
