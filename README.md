<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/poissonconsulting/datacheckr.svg?branch=master)](https://travis-ci.org/poissonconsulting/datacheckr) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/datacheckr)](http://cran.r-project.org/package=datacheckr) [![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/datacheckr)](https://hadley.shinyapps.io/cran-downloads)

datacheckr
==========

`datacheckr` is an R package to check data frame's rows, column names, column classes, values, unique keys and joins.

Why Another Data Checking Package?
----------------------------------

There are several existing R packages for checking data frames including `assertr`, `assertive` and `datacheck`. They are great for checking data in scripts but they have several limitations when embedded in functions in packages.

### Informative Error Messages

Consider the following code.

``` r
library(assertr)
assert(mtcars, within_bounds(0,1), mpg)
#> Error: 
#> Vector 'mpg' violates assertion 'within_bounds' 32 times (e.g. [21] at index 1)
```

The error message is not that helpful for a user who is not familiar with the internals of a function that has just thrown that error.

The same test using the `datacheckr::check_data()` function produces an error message which is more likely to allow the end user to diagnose the problem.

``` r
library(datacheckr)
check_data(mtcars, list(mpg = c(0,1)))
#> Error: the values in column mpg in mtcars must lie between 0 and 1
```

### Intuitive Checks

Consider the data frame `data1`

``` r
data1 <- data.frame(
  Count = c(0L, 3L, 3L, 0L), 
  LocationX = c(2000, NA, 2001, NA), 
  Extra = TRUE)
```

The following `datacheckr` code states that `data1` should have a column `Count` of non-missing integers with values of 0, 1 or 3, should not have a column `Comments` and *can* include a column `LocationX` with missing values between 1012 and 2345.

``` r
check_data(data1, list(
  Count = c(0L, 1L, 3L), 
  Comments = NULL, 
  LocationX = c(NA, 2345, 1012),
  LocationX = NULL))
```

To produce similar functionality with `assertr` would require something like (please file an [issue](https://github.com/poissonconsulting/datacheckr/issues) if the code below can be improved)

``` r
library(magrittr) # for the piping operator
data1 %>% assert(in_set(0, 1, 3), Count) %>%
  assert_rows(num_row_NAs, within_bounds(0,0.1), Count)
stopifnot(!"Comments" %in% colnames(data1))
if ("LocationX" %in% colnames(data1))
  data1 %>% assert(within_bounds(1012, 2345), LocationX)
```

which is in my opinion less intuitive.

### A Single Function Call

The above checks can be performed on several data frames by simply repeatedly calling `check_data()`

``` r
data3 <- data2 <- data1

values <- list(
  Count = c(0L, 1L, 3L), 
  Comments = NULL, 
  LocationX = c(NA, 2345, 1012),
  LocationX = NULL)

check_data(data1, values)
check_data(data2, values)
check_data(data3, values)
```

The same tests using `assertr` would require the `assertr` code above to be copied and pasted three times which is tedious to produce and read; and as a result error prone.

Installation
------------

To install the latest release version from CRAN

``` r
install.packages("datacheckr")
```

To install the development version from GitHub

``` r
# install.packages("devtools")
devtools::install_github("poissonconsulting/datacheckr")
```

More Information
----------------

For more information view `vignette("datacheckr")` for *An Introduction to checkdatar*.

Contact
-------

You are welcome to:

-   submit suggestions and bug reports at <https://github.com/poissonconsulting/datacheckr/issues>
-   send a pull request on <https://github.com/poissonconsulting/datacheckr>
