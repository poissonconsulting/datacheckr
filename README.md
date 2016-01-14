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

NYC FLIGHTS VIGNETTE
====================

> "It’s rare that a data analysis involves only a single table of data." ([Grolemund & Wickham](http://r4ds.had.co.nz/relational-data.html#nycflights13-relational))

Background
----------

This vignette demonstrates the use of the `datacheckr` R package in the context of relational data. It is a companion text to [Grolemund and Wickham](http://r4ds.had.co.nz/relational-data.html#nycflights13-relational)'s excellent in depth discussion of relational data.

``` r
# the examples use the development version of datacheckr
# devtools::install_github("poissonconsulting/datacheckr") 

library(dplyr) # so data prints nicely :)
library(magrittr) # cos I love piping
library(datacheckr) # check_data2, check_data3, check_key & check_join functions
library(nycflights13) # for the data frames we are going to work with
```

Check Data and Keys
-------------------

``` r
# the following code uses the check_data3 function to confirm that airlines
# has just two columns carrier and name in that order
# which are both factors (with non-missing values)
# and that carrier is unique
check_data3(airlines, list(carrier = factor(""), 
                           name = factor("")),
            key = "carrier")

# the following checks that airports has the listed columns in that order and that
# faa is a vector of strings (character vector) of three 'word characters', 
# name is a character vector,
# lat is a number between 0 and 90, lon is between -180 and 180,
# alt is an int between -100 and 10,000, tz should be obvious (by now)
# and dst is a character vector with the possible values A, N or U.
check_data3(airports, list(faa = rep("^\\w{3,3}$",2),
                           name = "",
                           lat = c(0, 90),
                           lon = c(-180, 180),
                           alt = as.integer(c(-100, 10^5L)),
                           tz = c(-11, 11),
                           dst = rep("A|N|U", 2)))

# woops this error means airports$faa is not unique!
check_key(airports, key = "faa")
#> Error: column 'faa' in airports must be a unique key

# checks that planes *includes* tailnum, engines and year 
# (as using less strict check_data2) and that
# engines is 1, 2, 3 or 4, that
# year is an integer between 1956 and 2013 that can include
# missing values and tailnum (which consists of strings of
# 5 to 6 'word characters') is the unique key.
check_data2(planes, list(tailnum = rep("^\\w{5,6}$",2),
                         engines = 1:4,
                         year = c(1956L, 2013L, NA)),
            key = "tailnum")

# weather has lots of columns. by setting select = TRUE in check_data3
# we drop non-named columns and order to match values.
# the checks indicate that year is only 2013, and like month is a number
# but day and hour are ints (as expected)
# also looks like someone forgot to record the date and time
# for at least one observation but at least all the columns
# form a unique key (key = NULL)
weather %<>% check_data3(list(year = c(2013,2013),
                              month = c(1, 12, NA),
                              day = c(1L, 31L, NA),
                              hour = c(0L, 23L, NA),
                              origin = rep("^\\w{3,3}$",2)),
                 key = NULL, select = TRUE)

print(weather)
#> Source: local data frame [8,719 x 5]
#> Groups: month, day, hour [8719]
#> 
#>     year month   day  hour origin
#>    (dbl) (dbl) (int) (int)  (chr)
#> 1   2013     1     1     0    EWR
#> 2   2013     1     1     1    EWR
#> 3   2013     1     1     2    EWR
#> 4   2013     1     1     3    EWR
#> 5   2013     1     1     4    EWR
#> 6   2013     1     1     6    EWR
#> 7   2013     1     1     7    EWR
#> 8   2013     1     1     8    EWR
#> 9   2013     1     1     9    EWR
#> 10  2013     1     1    10    EWR
#> ..   ...   ...   ...   ...    ...

# we just have flights for 2013 and hour includes
# the impossible value of 24 as well as missing values.
# tailnum includes "" as well as 5 and 6 character codes.
check_data2(flights, list(year = c(2013L,2013L),
                          month = c(1L,12L),
                          day = c(1L, 31L),
                          hour = c(0, 24, NA),
                          origin = rep("^\\w{3,3}$",2),
                          dest = rep("^\\w{3,3}$",2),
                          tailnum = rep("^(\\w{5,6}|)$",2),
                          carrier = rep("^\\w{2,2}$",2)))
```

Check Joins
-----------

``` r
# we can't simply join flights and airlines
# as carrier is a different classes in the two data sets
check_join(flights, airlines, join = "carrier")
#> Error: join columns in flights and airlines must have identical classes
# easy to fix though
airlines$carrier %<>% as.character()
check_join(flights, airlines, join = "carrier")

# we also have to be careful joining flights and airport by faa and origin
# as the fact that faa is not a unique key
# raises its ugly head
check_join(flights, airports, join = c(origin = "faa"))
#> Error: column 'faa' in airports must be a unique key

# we also can't simply join flights and planes using tailnum as there are
# extra matching columns (which will be renamed) and more worringly
# the (many-to-one) relationship violates referential integrity (flights without planes)
check_join(flights, planes, join = "tailnum", extra = TRUE)
#> Error: many-to-one join between flights and planes violates referential integrity
```

The Future?
-----------

### coerce = TRUE

An [obvious enhancement](https://github.com/poissonconsulting/datacheckr/issues/6) would be an argument `coerce = FALSE` in the `check_data2`, `check_data3` and `check_join` functions to allow class coercion to be switched on. If `coerce = TRUE` then provided no information is lost, vectors could automatically coerced to match the class in values for data checking and the class in parent for join checking and the altered data frame returned.
