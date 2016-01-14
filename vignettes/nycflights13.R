## ---- message = FALSE----------------------------------------------------
# the examples use the development version of datacheckr
# devtools::install_github("poissonconsulting/datacheckr") 

library(dplyr) # so data prints nicely :)
library(magrittr) # cos I love piping
library(datacheckr) # check_data2, check_data3, check_key & check_join functions
library(nycflights13) # for the data frames we are going to work with

## ---- error = TRUE-------------------------------------------------------
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

## ---- error = TRUE-------------------------------------------------------
# we can't simply join flights and airlines
# as carrier is a different classes in the two data sets
check_join(flights, airlines, join = "carrier")
# easy to fix though
airlines$carrier %<>% as.character()
check_join(flights, airlines, join = "carrier")

# we also have to be careful joining flights and airport by faa and origin
# as the fact that faa is not a unique key
# raises its ugly head
check_join(flights, airports, join = c(origin = "faa"))

# we also can't simply join flights and planes using tailnum as there are
# extra matching columns (which will be renamed) and more worringly
# the (many-to-one) relationship violates referential integrity (flights without planes)
check_join(flights, planes, join = "tailnum", extra = TRUE)

