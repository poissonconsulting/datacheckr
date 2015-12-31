<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/poissonconsulting/datacheckr.svg?branch=master)](https://travis-ci.org/poissonconsulting/datacheckr)

datacheckr
==========

`datacheckr` is an R package to check the names, classes and values of columns in objects inheriting from class `data.frame`.

Why Another Data Checking Package?
----------------------------------

There are several existing R packages for checking data including `assertr`, `assertive` and `datacheck`. They are great for checking data in scripts but they have several limitations when embedded in functions in packages.

### Informative Error Messages

Consider the following:

``` r
library(assertr)
assert(mtcars, within_bounds(0,1), mpg)
#> Error: 
#> Vector 'mpg' violates assertion 'within_bounds' 32 times (e.g. [21] at index 1)
```

The error is not that helpful for a user who is not familiar with the internals of a function that has just thrown that error.

The same test using `datacheckr` only exported function `check_data`

``` r
library(datacheckr)
check_data(mtcars, list(mpg = c(0,1)))
#> Error: the values in column mpg in mtcars must lie between 0 and 1
```

produces an error message which is more likely to allow the end user to diagnose the problem.

### Intuitive Checks

Consider the data frame `data1`

``` r
data1 <- data.frame(Count = c(0L, 3L, 3L, 0L), 
                    LocationX = c(2000, NA, 2001, NA), 
                    Extra = TRUE)
```

The following `data_checkr` code states that `data1` should have a column `Count` of non-missing integers with values of 0, 1 or 3, should not have a column `Comments` and can include a column `LocationX` with missing values between 1012 and 2345.

``` r
check_data(data1, list(Count = c(0L, 1L, 3L), 
  Comments = NULL, 
   LocationX = c(NA, 2345, 1012),
   LocationX = NULL))
```

To produce similar functionality with `assertr` would require something like (please file an issue if the code below can be improved)

``` r
library(magrittr) # for the piping operator
data1 %>% assert(in_set(0, 1, 3), Count) %>%
  assert_rows(num_row_NAs, within_bounds(0,0.1), Count)
stopifnot(!"Comments" %in% colnames(data1))
if ("LocationX" %in% colnames(data1))
  data1 %>% assert(within_bounds(1012, 2345), LocationX)
```

which is in my opinion less intuitive.

For more explanation of the `datacheck` syntax see below.

### A Single Function Call

To repeat the above checks on several data frames can be achieved very efficiently using `check_data`

``` r
data3 <- data2 <- data1

values <- list(Count = c(0L, 1L, 3L), 
  Comments = NULL, 
   LocationX = c(NA, 2345, 1012),
   LocationX = NULL)

check_data(data1, values)
check_data(data2, values)
check_data(data3, values)
```

The same tests using `assertr` would require the `assertr` code above to be copied and pasted three times which is tedious to produce and read and as a result error prone.

data\_check
-----------

The `datacheckr` package exports a single function `data_check` which takes two arguments: the data frame to check and a named list specifying the various conditions.

### Checking Columns and Classes

The names of the list elements specify the columns that need to appear in the data frame while the classes of the vectors specify the classes of the columns.

Thus, to specify that x should contain a column called `col1` of class integer the call would be as follows.

``` r
check_data(mtcars, list(col1 = integer()))
#> Error: column col1 in mtcars must be of class 'integer'
```

To specify that x should *not* contain a column called `mpg` the call is just

``` r
check_data(mtcars, list(mpg = NULL))
#> Error: mtcars must not include column mpg
```

and to specify that it can contain a column `col1` that can be integer or numeric values the call would be

``` r
check_data(mtcars, list(col1 = integer(), 
                  col1 = NULL, 
                  col1 = numeric()))
```

If a column is not named in the list then no checks are performed on it.

### Checking Missing Values

To specify that a column cannot include missing values pass a single non-missing value.

``` r
check_data(mtcars, list(mpg = 3))
check_data(mtcars, list(mpg = -1))
```

To specify that it can include missing values include an NA in the vector

``` r
check_data(mtcars, list(mpg = c(NA, 9)))
```

and to specify that it can only include missing values use

``` r
check_data(mtcars, list(mpg = as.numeric(NA)))
#> Error: column mpg in mtcars can only include missing values
```

### Checking Ranges

To indicate that the non-missing values must fall within a range use two non-missing values (the following code tests for counts).

``` r
check_data(data1, list(Count = c(0L, .Machine$integer.max)))
```

### Checking Specific Values

If particular values are required then specify them as a vector of three or more non-missing values

``` r
check_data(data1, list(Count = c(0L, 1L, 3L)))
```

The order is unimportant.

### Checking Numeric, Date and POSIXct Vectors

Numeric, Date and POSIXct vectors have exactly the same behaviour regarding ranges and specific values as illustrated above using integers.

### Checking Logical Vectors

With logical values two non-missing values produce the same behaviour as three or more non-missing values. For example to test for only `TRUE` values use

``` r
check_data(data1, list(Extra = c(TRUE, TRUE)))
```

### Checking Character Vectors

To specify that `col1` must be a character vector use

``` r
check_data(x, list(col1 = "b"))
```

while the following requires that the values match both character elements which are treated as regular expressions

``` r
check_data(x, list(col1 = c("^//d", ".*")))
```

with three or more non-missing character elements each value in `col1` must match at least one of the elements which are treated as regular expressions. Regular expressions are matched using `grepl` with `perl=TRUE`.

### Checking Factors

To indicate that `supp` should be a factor use either of the following

``` r
check_data(ToothGrowth, list(supp = factor()))
check_data(ToothGrowth, list(supp = factor("blahblah")))
```

To specify that `supp` should be a factor that includes the factor levels `OJ` and `VC` (in any order) just pass two non-missing values

``` r
check_data(ToothGrowth, list(supp = factor(c("VC", "OJ"))))
```

And to specify the actual factor levels that `supp` must have pass three or more non-missing values

``` r
check_data(ToothGrowth, list(supp = factor(c("VC", "OJ", "OJ"))))
```

Installation
------------

To install the latest release version from GitHub

``` r
library(devtools)
install_github("poissonconsulting/datacheckr@v0.0.1")
```

To install the development version from GitHub

``` r
library(devtools)
install_github("poissonconsulting/datacheckr")
```

Contact
-------

You are welcome to:

-   submit suggestions and bug reports at: <https://github.com/poissonconsulting/datacheckr/issues>
-   send a pull request on: <https://github.com/poissonconsulting/datacheckr>
