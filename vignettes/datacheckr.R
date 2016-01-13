## ---- error = TRUE-------------------------------------------------------
library(datacheckr)
check_data(mtcars, list(col1 = integer()))

## ---- error = TRUE-------------------------------------------------------
check_data(mtcars, list(mpg = NULL))

## ------------------------------------------------------------------------
check_data(mtcars, list(
  col1 = integer(), 
  col1 = NULL, 
  col1 = numeric()))

## ------------------------------------------------------------------------
check_data(mtcars, list(mpg = 3))
check_data(mtcars, list(mpg = -1))

## ------------------------------------------------------------------------
check_data(mtcars, list(mpg = c(NA, 9)))

## ---- error = TRUE-------------------------------------------------------
check_data(mtcars, list(mpg = as.numeric(NA)))

## ------------------------------------------------------------------------
data1 <- data.frame(
  Count = c(0L, 3L, 3L, 0L), 
  LocationX = c(2000, NA, 2001, NA), 
  Extra = TRUE)

check_data(data1, list(Count = c(0L, .Machine$integer.max)))

## ------------------------------------------------------------------------
check_data(data1, list(Count = c(0L, max_integer())))

## ------------------------------------------------------------------------
check_data(data1, list(Count = c(0L, 1L, 3L)))

## ---- error=TRUE---------------------------------------------------------
check_data(data1, list(Count = c(1L, 2L, 2L)))

## ------------------------------------------------------------------------
check_data(data1, list(Extra = c(TRUE, TRUE)))

## ------------------------------------------------------------------------
check_data(ToothGrowth, list(supp = factor()))
check_data(ToothGrowth, list(supp = factor("blahblah")))

## ------------------------------------------------------------------------
check_data(ToothGrowth, list(supp = factor(c("VC", "OJ"))))

## ------------------------------------------------------------------------
check_data(ToothGrowth, list(supp = factor(c("VC", "OJ", "OJ"))))

## ---- error=TRUE---------------------------------------------------------
# if values is unspecified it simply checks that data is a data frame
check_data(1)
check_data(mtcars)

# column names and classes are specified by
# the names and classes of the elements of values
check_data(mtcars, list(mpg = NULL))
check_data(mtcars, list(mpg = integer()))
check_data(mtcars, list(mpg = integer(), mpg = logical()))
check_data(mtcars, list(mpg = integer(),
                        mpg = logical(),
                        mpg = numeric()))
check_data(mtcars, list(mpg = numeric()))
check_data(mtcars, list(mpg = 2L))
check_data(mtcars, list(mpg = 35))

# two non-missing values indicate a range
check_data(mtcars, list(mpg = c(20, 35)))
check_data(mtcars, list(mpg = c(10, 35)))
check_data(mtcars, list(mpg = c(10, 35), gear = c(3, 5)))

# three or more non-missing values indicate specific values
check_data(mtcars, list(mpg = c(10, 35), gear = c(3, 5, 6)))
check_data(mtcars, list(mpg = c(10, 35), gear = c(3, 4, 5)))
# order is unimportant
check_data(mtcars, list(gear = c(4, 3, 5), mpg = c(35, 10)))

# to permit missing values simply include an NA
# (with a non-missing value)
is.na(mtcars$gear[2]) <- TRUE
check_data(mtcars, list(gear = numeric()))
check_data(mtcars, list(gear = -3))
check_data(mtcars, list(gear = c(-3, NA)))
check_data(mtcars, list(gear = NA))
check_data(mtcars, list(gear = as.numeric(NA)))

