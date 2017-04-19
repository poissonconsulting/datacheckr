### v0.2.0.9000

- Fixed bug in check_key when checking sf data frames with key = character(0)

## v0.2.0

- Removed `check_data` which was deprecated in v0.1.0.
- Removed all dependencies.
- Moved vignettes into README

### v0.1.2

- Add function `check_unique()` to confirm an object doesn't have any duplicated elements.

### v0.1.1

- Fixed tests so that compatible with testthat v0.11.0.9000

## v0.1.0

- Added arguments `min_row = 0` and `max_row = max_nrow()` to `check_data`
to allow checking of the number of rows.
- Added argument `key = character(0)` to `check_data` to allow checking of a unique key.

- Added stricter variants of `check_data` called `check_data2` and `check_data3`
as well as an alias `check_data1` for `check_data` and deprecated `check_data`.

- Added function `check_vector` to check the class and values of a vector.
- Added function `check_scalar` to check the class and values of a scalar.
- Added functions `check_flag`, `check_int`, `check_count`, `check_string`, 
`check_date` and `check_time` functions for specific scalars.
- Added function `check_data_frame` to check if an object is a data frame.
- Added function `check_rows` to check the number of rows in a data frame.
- Added function `check_cols` to check the names of columns in a data frame.
- Added function `check_values` to check the classes and values of the columns in a data frame.
- Added function `check_key` to check that particular columns represent unique keys.
- Added function `check_join` to check a many-to-one join between two data frames.
- Added wrapper function `max_nrow()` to return the theoretical maximum number of rows.
- Added function `min_integer` as wrapper for `-.Machine$integer.max`.

- Value checking now works with columns inheriting from base classes i.e. ordered factors.
- Added argument `data_name = substitute(data)` to all functions so users can overide
the name of data.

### v0.0.2

- Added vignette datacheckr.
- The copy of the original data frame returned by `check_data` is now invisible.
- Added function `max_integer` as wrapper for `.Machine$integer.max`.
- On fail `check_data` now lists specific permitted values if 5 or less 
(if 3 or less for character)

## v0.0.1

- Initial Release
