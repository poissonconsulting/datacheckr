context("checkor")

test_that("checkor works", {
  expect_identical(checkor(), TRUE)
  expect_identical(checkor(x <- 1), TRUE)
  expect_error(checkor(stop()), "^$")
  expect_error(checkor(stop("that")), "^that$")
  expect_error(checkor(stop("that"), y <- 2, stop("this")), "^that OR this$")
  expect_error(checkor(stop("that"), y <- 2, stop("this"), stop("that")), "^that OR this$")
  expect_error(checkor(stop("that"), y <- 2, stop("this"), check_data1(1)), "that OR this OR 1 must be a data frame")
})
