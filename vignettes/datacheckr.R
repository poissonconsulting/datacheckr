## ---- error = TRUE-------------------------------------------------------
library(datacheckr)
check_data2(mtcars, list(col1 = integer()))

## ---- error = TRUE-------------------------------------------------------
check_data2(mtcars, list(mpg = NULL))

## ------------------------------------------------------------------------
check_data1(mtcars, list(
  col1 = integer(), 
  col1 = NULL, 
  col1 = numeric()))

## ------------------------------------------------------------------------
check_data2(mtcars, list(mpg = 3))
check_data2(mtcars, list(mpg = -1))

## ------------------------------------------------------------------------
check_data2(mtcars, list(mpg = c(NA, 9)))

## ---- error = TRUE-------------------------------------------------------
check_data2(mtcars, list(mpg = as.numeric(NA)))

## ------------------------------------------------------------------------
data1 <- data.frame(
  Count = c(0L, 3L, 3L, 0L), 
  LocationX = c(2000, NA, 2001, NA), 
  Extra = TRUE)

check_data2(data1, list(Count = c(0L, .Machine$integer.max)))

## ------------------------------------------------------------------------
check_data2(data1, list(Count = c(0L, max_integer())))

## ------------------------------------------------------------------------
check_data2(data1, list(Count = c(0L, 1L, 3L)))

## ---- error=TRUE---------------------------------------------------------
check_data2(data1, list(Count = c(1L, 2L, 2L)))

## ------------------------------------------------------------------------
check_data2(data1, list(Extra = c(TRUE, TRUE)))

## ------------------------------------------------------------------------
check_data2(ToothGrowth, list(supp = factor()))
check_data2(ToothGrowth, list(supp = factor("blahblah")))

## ------------------------------------------------------------------------
check_data2(ToothGrowth, list(supp = factor(c("VC", "OJ"))))

## ------------------------------------------------------------------------
check_data2(ToothGrowth, list(supp = factor(c("VC", "OJ", "OJ"))))

