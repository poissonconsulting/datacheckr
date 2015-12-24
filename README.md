<!-- README.md is generated from README.Rmd. Please edit that file -->
deckr
=====

This README is the outline for a possible an R package to check the names, classes and values of columns in objects inheriting from class data.frame.

The Problem
-----------

Most of the packages I write need to check that one or more user supplied data frames have the correct type of data in them before proceeding to analysis or plotting. If they don't the packages need to provide a helpful error message so the user is able to correct the input data. To the best of my knowledge an elegant solution to this problem does not currently exist. If you think it does please let me know right away <joe@poissonconsulting.ca>.

A Solution?
-----------

I need a function that is able to input a data frame and test whether or not it includes certain named columns of particular classes that may or may not contain particular values including missing values. If not it should return an informative error message if so it should return the original data frame so it is able to be used in piping sequences.

It seems to me that a function that takes the input data frame and a named list of vectors specifying the possible values would fit the bill. Let us call it `deck`. The names of the list elements would specify those columns that need to appear in the data.frame while the classes of the vectors would specify the classes of the column.

Thus, to specify that x should contain a column called `col1` of class integer the call would be one of the following because with a single value only its class matters.

    deck(x, list("col1" = 1L))
    deck(x, list("col1" = 2L))

To specify that x should not contain a column called `col1` the call is just

    deck(x, list("col1" = NULL))

and to specify that it can contain a column `col1` that can be integer or numeric values the call would be

    deck(x, list("col1" = 3L, "col1" = NULL, "col1" = 9))

To specify that a column can include missing values just add an `NA` to the vector.

    deck(x, list("col1" = c(1L, NA)))

And to indicate that it must fall within a range use two non-missing values (the following code tests for counts).

    deck(x, list("col1" = c(0L, .Machine$integer.max)))

If particular values are required then specify them as vector of three or more missing values

    deck(x, list("col1" = c(0L, 1L, 4L)))

The above code test that `col1` contains just the counts 0, 1 and 4.

Missing values, ranges and particular values work identically for numeric, and Date vectors while for logical values two and three or more non-missing values behave identically, i.e., use `deck(x, list("col1" = c(TRUE, TRUE)))` to indicate only `TRUE` values.

To specify that `col1` must be a character vector use

    deck(x, list("col1" = "b"))

while the following requires that the values match both character elements which are treated as regular expressions

    deck(x, list("col1" = c("^//d", ".*")))

with three or more non-missing character elements each value in `col1` must match at least one.

The behaviour of `deck` should be independent of the order of the list elements (or the vector elements for that matter).

The following call says `x` must have a `col1` that is a integer or numeric and `col2` that is a Date and no columns called `col3`.

    deck(x, list("col1" = 3L, "col1" = NULL, "col1" = 9))
