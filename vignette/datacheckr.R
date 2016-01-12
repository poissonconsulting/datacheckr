## ---- error = TRUE-------------------------------------------------------
library(datacheckr)
check_data(mtcars, list(col1 = integer()))

## ---- error = TRUE-------------------------------------------------------
check_data(mtcars, list(mpg = NULL))

