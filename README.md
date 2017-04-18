
<!-- README.md is generated from README.Rmd. Please edit that file -->
![stability-stable](https://img.shields.io/badge/stability-stable-green.svg) [![Travis-CI Build Status](https://travis-ci.org/poissonconsulting/datacheckr.svg?branch=master)](https://travis-ci.org/poissonconsulting/datacheckr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/datacheckr?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/datacheckr) [![codecov](https://codecov.io/gh/poissonconsulting/datacheckr/branch/master/graph/badge.svg)](https://codecov.io/gh/poissonconsulting/datacheckr) [![License: CC0](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/datacheckr)](https://cran.r-project.org/package=datacheckr) [![CRAN Downloads](http://cranlogs.r-pkg.org/badges/grand-total/datacheckr)](http://www.r-pkg.org/pkg/cranlogs)

datacheckr
==========

Introduction
------------

`datacheckr` is an R package to check the column names, classes, values, keys and joins in data frames. It provides an informative error message if a user-defined condition fails to be met otherwise it returns the object (so it can be used in pipes).

Demonstration
-------------

Consider the data frame `my_data`

``` r
library(tibble)

my_data <- data_frame(
  Count = c(0L, 3L, 3L, 0L, NA), 
  Longitude = c(0, 0, 90, 90, 180), 
  Latitude = c(0, 90, 90.2, 100, -180),
  Type = factor(c("Good", "Bad", "Bad", "Bad", "Bad"), levels = c("Good", "Bad")),
  Extra = TRUE,
  Comments = c("In Greenwich", "Somewhere else", "I'm lost", "I didn't see any", "Help"))

my_data
#> # A tibble: 5 × 6
#>   Count Longitude Latitude   Type Extra         Comments
#>   <int>     <dbl>    <dbl> <fctr> <lgl>            <chr>
#> 1     0         0      0.0   Good  TRUE     In Greenwich
#> 2     3         0     90.0    Bad  TRUE   Somewhere else
#> 3     3        90     90.2    Bad  TRUE         I'm lost
#> 4     0        90    100.0    Bad  TRUE I didn't see any
#> 5    NA       180   -180.0    Bad  TRUE             Help
```

### Integers

To specify that `my_data` *must* contain a column called `col1` of class integer use the `check_data2` function

``` r
library(datacheckr)
check_data2(my_data, values = list(col1 = integer()))
#> Error: my_data must have column 'col1'
```

### Missing Values

To specify that a column cannot include missing values pass a single non-missing value (of the correct class)

``` r
check_data2(my_data, list(Count = 1L))
#> Error: column Count in my_data cannot include missing values
```

To specify that it can include missing values include an NA in the vector

``` r
check_data2(my_data, list(Count = c(1L, NA)))
```

and to specify that it can only include missing values pass an NA (of the correct class)

``` r
check_data2(my_data, list(Count = NA_integer_))
#> Error: column Count in my_data can only include missing values
```

Value Ranges
------------

To indicate that the values must fall within a range use two non-missing values

``` r
check_data2(my_data, list(Count = c(0L, 2L)))
#> Error: column Count in my_data cannot include missing values
```

Specific Values
---------------

If particular values are required then specify them as a vector of three or more non-missing values

``` r
check_data2(my_data, list(Count = c(1L, 2L, 2L)))
#> Error: column Count in my_data cannot include missing values
```

The order of the values in an element is unimportant.

### Numeric, Date and POSIXct

Numeric, Date and POSIXct columns have exactly the same behaviour regarding ranges and specific values as illustrated above using integers.

### Logical

With logical values two non-missing values produce the same behaviour as three or more non-missing values.

For example to test for only `FALSE` values use

``` r
check_data2(my_data, list(Extra = c(FALSE, FALSE)))
#> Error: column Extra in my_data can only include FALSE values
```

### Characters

The following requires that the values of `Comments` match both character elements which are treated as regular expressions

``` r
check_data2(my_data, list(Comments = c("e", "o")))
#> Error: column Comments in my_data contains strings that do not match both regular expressions 'e' and 'o'
```

with three or more non-missing character elements each value must match at least one of the elements which are treated as regular expressions.

``` r
check_data2(my_data, list(Comments = c("e", "o", "o")))
```

Regular expressions are matched using `grepl` with `perl=TRUE`.

### Factors

To specify that `Type` should be a factor that includes `"Bad1"` and `"Good"` among its levels

``` r
check_data2(my_data, list(Type = factor(c("Bad1", "Good"))))
#> Error: column Type in my_data lacks factor levels 'Bad1' and 'Good'
```

And to specify the actual factor levels, pass three or more non-missing values

``` r
check_data2(my_data, list(Type = factor(c("Bad", "Good", "Good"))))
#> Error: column Type in my_data must be a factor with the levels 'Bad' and 'Good'
```

### Column Names

Whereas `check_data2()` ignores unnamed columns and doesn't care about the order, `check_data3()` requires that column names match the names in values.

``` r
check_data3(my_data, list(Comments = character()))
#> Error: column names in my_data must be identical to 'Comments'
```

### Missing Columns

In contrast, `check_data1()` can be used to test that specific columns are missing or that a column satisfies one of multiple conditions.

``` r
check_data1(my_data, list(Comments = NULL))
#> Error: my_data must not include column Comments
```

``` r
check_data1(my_data, list(Comments = integer(),
                          Comments = numeric()))
#> Error: column Comments in my_data must be of class 'integer' or 'numeric'
```

To specify that `my_data` *can* contain a column `col1` that can be integer or numeric values the call would be

``` r
check_data1(my_data, list(
  col1 = integer(), 
  col1 = NULL, 
  col1 = numeric()))
```

### Naming Objects

By default, `datacheckr` determines the name of an object based on the call. This results in uninformative error messages when used in a pipe

``` r
library(magrittr)
my_data %<>% check_data2(values = list(col1 = integer()))
#> Error: . must have column 'col1'
```

The argument `data_name` can be used to define the name

``` r
library(magrittr)
my_data %<>% check_data2(values = list(col1 = integer()), data_name = "d8r")
#> Error: d8r must have column 'col1'
```

### Relational Data

Consider the [relational data](http://r4ds.had.co.nz/relational-data.html#nycflights13-relational) in the `nycflights13` package.

#### Keys

The following code uses the `check_data3` function to confirm that airlines has just two columns `carrier` and `name`, in that order, which are both character vectors and that carrier is unique (a key).

``` r
library(nycflights13)
check_data3(airlines, list(carrier = "", 
                           name = ""),
            key = "carrier")
```

The next code checks that `airports` has the listed columns in that order and that `faa` is a unique character vector of three 'word characters', `lat` is a number between 0 and 90, `alt` is an integer between -100 and 10,000, and `dst` is a character vector with the possible values A, N or U.

``` r
check_data3(airports, list(faa = rep("^\\w{3,3}$",2),
                           name = "",
                           lat = c(0, 90),
                           lon = c(-180, 180),
                           alt = as.integer(c(-100, 10^5L)),
                           tz = c(-11, 11),
                           dst = rep("A|N|U", 2),
                           tzone = ""),
            key = "faa")
```

This checks that planes *includes* tailnum, engines and year (as using less strict `check_data2`) and that engines is 1, 2, 3 or 4, that year is an integer between 1956 and 2013 that can include missing values and tailnum (which consists of strings of 5 to 6 letter 'word characters') is the unique key.

``` r
check_data2(planes, list(tailnum = rep("^\\w{5,6}$",2),
                         engines = 1:4,
                         year = c(1956L, 2013L, NA)),
            key = "tailnum")
```

#### Selecting Columns

Weather has lots of columns. by setting `select = TRUE` in `check_data3` we drop non-named columns and order to match values. The checks indicate that year is only 2013, and like month is a number but day and hour are integers (as expected)

``` r
weather %<>% check_data3(list(year = c(2013,2013),
                              month = c(1, 12),
                              day = c(1L, 31L),
                              hour = c(0L, 23L),
                              origin = rep("^\\w{3,3}$",2)),
                 select = TRUE)
weather
#> # A tibble: 26,130 × 5
#>     year month   day  hour origin
#>    <dbl> <dbl> <int> <int>  <chr>
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
#> # ... with 26,120 more rows
```

#### Joins

Checking the referential integrity of the (many-to-one) join between `flights` and `airlines` is easy.

``` r
check_join(flights, airlines, join = "carrier")
```

In addition to `tailnum`, `flights` and `planes` have additional column with the same name.

``` r
check_join(flights, planes, join = "tailnum")
#> Error: flights and planes must not have additional matching columns
```

We can deal with this by setting `extra = TRUE` but the data fail referential integrity because we have planes without flights.

``` r
check_join(flights, planes, extra = TRUE, join = "tailnum")
#> Error: many-to-one join between flights and planes violates referential integrity
```

Installation
------------

To install the most recent release from CRAN

    install.packages("datacheckr")

To install the development version from GitHub

    # install.packages("devtools")
    devtools::install_github("datacheckr")

Contribution
------------

Please report any [issues](https://github.com/poissonconsulting/datacheckr/issues).

[Pull requests](https://github.com/poissonconsulting/datacheckr/pulls) are always welcome.

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
