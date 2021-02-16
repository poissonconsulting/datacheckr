test_that("check_unique errors", {
  expect_identical(check_unique(1), 1)
  expect_identical(check_unique(1:2), 1:2)
  expect_identical(check_unique(character(0)), character(0))
  expect_error(check_unique(c(1,1)), "c[(]1, 1[)] must be unique")
})
