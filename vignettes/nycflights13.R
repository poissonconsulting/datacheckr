## ---- error = TRUE-------------------------------------------------------
# the examples use the development version of datacheckr
# devtools::install_github("poissonconsulting/datacheckr") 

library(dplyr) # so data prints nicely :)
library(datacheckr)
library(nycflights13) # the data frames we are going to work with

# the following code uses the check_data3 function to check that airlines
# has just two columns carrier and name in that order
# which are both factors (with non-missing values)
# and that carrier is unique
check_data3(airlines, list(carrier = factor(""), 
                           name = factor("")),
            key = "carrier")

# checks that airports has the listed columns in that order and that
# faa is a strings of three word characters, name is a character,
# lat is a number between 0 and 90, lon is between -180 and 180,
# alt is an int between -100 and 10,000, tz should be obvious
# and dst is a character vector with the possible values A, N or U.
check_data3(airports, list(faa = rep("^\\w{3,3}$",2),
                           name = "",
                           lat = c(0, 90),
                           lon = c(-180, 180),
                           alt = as.integer(c(-100, 10^5L)),
                           tz = c(-11, 11),
                           dst = rep("A|N|U", 2)))

# woops airports$faa is not unique!
check_key(airports, key = "faa")

# checks that planes *includes* tailnum, engines and year 
# (as using less strict check_data2) and that
# engines is 1, 2, 3 or 4, that
# year is an integer between 1956 and 2013 that can include
# missing values and tailnum (which consists of strings of
# 3 word characters) is the key
check_data2(planes, list(tailnum = rep("^\\w{3,3}$",2),
                         engines = 1:4,
                         year = c(1956L, 2013L, NA)),
            key = "tailnum")

# weather has lots of columns by selecting just 
# the ones we are interested we can use
# the stricter check_data3
weather <- select(weather, year, month, day, hour, origin)
# interesting! year is only 2013, and like month is a number
# but day and hour are ints (as expected)
# also looks like someone forgot to record the date and time
# for at least one observation but at least all the columns
# form a unique key
check_data3(weather,list(year = c(2013,2013),
                              month = c(1, 12, NA),
                              day = c(1L, 31L, NA),
                              hour = c(0L, 23L, NA),
                              origin = rep("^\\w{3,3}$",2)),
                 key = NULL)

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

# and the supposed key is not unique
check_key(flights, c("year", "month", "day", "hour", "origin"))

# darn we can't join flights and airlines in an many-to-one relationship
# as carrier is different classes
check_join(flights, airlines, join = "carrier")
# and flights doesn't have faa (its called origin)
check_join(flights, airports, join = "faa")
# we can join flights and planes using tailnum if we ignore the fact that
# the many-to-one relationship violates referential integrity (flights without planes)
# and there are extra matching columns
check_join(flights, planes, join = "tailnum", referential = FALSE, extra = TRUE)
# different  classes strikes again
check_join(flights, weather)

