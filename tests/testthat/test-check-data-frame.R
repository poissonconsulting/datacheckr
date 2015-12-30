context("check-data-frame")

test_that("check_data_frame passes", {
  expect_true(check_data_frame(data.frame(A = 1, b = 2L), "w"))
  expect_true(check_data_frame(data.frame(), "w"))
})

test_that("check_data_frame fails", {
  expect_error(check_data_frame(3, "w"), "w must be a data frame")

  data <- data.frame("A" = 1, "b" = 2L, "c" = 4L)
  colnames(data) <- c("A", "b", "A")
  expect_error(check_data_frame(data, "w"),
               "w must be a data frame with unique column names")
})
