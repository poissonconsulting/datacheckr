context("checkor")

test_that("checkor works", {
  expect_identical(checkor(), TRUE)
  expect_identical(checkor(x <- 1), TRUE)
  expect_error(checkor(stop()), "^$")
  expect_error(checkor(stop("that")), "^that$")
  expect_identical(checkor(stop("that"), y <- 2), TRUE)
  expect_error(checkor(stop("that"), stop("this"), stop("these")), "^that OR this OR these$")
  expect_error(checkor(stop("that"), stop("this"), stop("that")), "^that OR this$")
  expect_error(checkor(stop("that"), stop("this"), check_data1(1)), "that OR this OR 1 must be a data frame")

  fun <- function(x) checkor(check_flag(x))
  expect_error(checkor(fun(1)), "^x must be of class 'logical'$")
})
