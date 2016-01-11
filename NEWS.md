# development version

- `check_data` now works with columns inheriting from base classes.
- Added function `max_nrow()` a wrapper on the theoretical maximum number of rows.
- Added `min_row` and `max_row` arguments to `data_check` for checking nrow in data.

# datacheckr v0.0.2

- Added vignette datacheckr.
- The copy of the original data frame returned by `check_data` is now invisible.
- Added function `max_integer` as wrapper for `.Machine$integer.max`.
- On fail `check_data` now lists specific permitted values if 5 or less 
(if 3 or less for character)

# datacheckr v0.0.1

- Initial Release
