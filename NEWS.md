# development version


- Added function `check_data_frame` to check if an object is a data frame.
- Added function `check_rows` to check the number of rows in a data frame.
- Added function `check_cols` to check the names of columns in a data frame.
- Added function `check_values` to check the classes and values of the columns in a data frame.
- Added function `check_key` to check that particular columns represent unique keys.
- Added function `check_join` to check a many-to-one join between two data frames.
- Added function `max_nrow()` to return the theoretical maximum number of rows.

- `check_data` now has argument `unique = FALSE` to enforce that columns can only have
one class (useful with lots of columns to check not misspecified names).
- `check_data` now works with columns inheriting from base classes i.e. ordered factors.
- Added `min_row` and `max_row` arguments to `data_check` for checking number of rows in data.


# datacheckr v0.0.2

- Added vignette datacheckr.
- The copy of the original data frame returned by `check_data` is now invisible.
- Added function `max_integer` as wrapper for `.Machine$integer.max`.
- On fail `check_data` now lists specific permitted values if 5 or less 
(if 3 or less for character)

# datacheckr v0.0.1

- Initial Release
