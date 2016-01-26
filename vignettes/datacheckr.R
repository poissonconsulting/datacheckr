## ---- error = TRUE-------------------------------------------------------
library(datacheckr)
check_data2(mtcars, list(col1 = integer()))

## ---- error = TRUE-------------------------------------------------------
check_data2(mtcars, list(mpg = NULL))

