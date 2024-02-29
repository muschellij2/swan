
<!-- README.md is generated from README.Rmd. Please edit that file -->

# swan

<!-- badges: start -->
<!-- badges: end -->

The goal of swan is to estimate Sleep-wear, Wake-wear, and Non-wear
(‘SWaN’) in wrist-worn accelerometry. The `swan` packagge creates a
specific ‘conda’ environment and wrappers apply this to rawdata
(sub-second) to get an estimate of non-wear in 30 second blocks. It
wraps the Python implementation
<https://github.com/binodthapachhetry/SWaN> published in ‘Detecting
Sleep and Nonwear in 24-h Wrist Accelerometer Data from the National
Health and Nutrition Examination Survey’
<https://doi.org/10.1249%2FMSS.0000000000002973>.

## Installation

You can install the development version of `swan` like so:

``` r
remotes::install_github("jhuwit/swan")
```

## Example

``` r
library(swan)
unset_reticulate_python()
use_swan_condaenv()
file = system.file("extdata", "73557_subset.csv.gz", package = "swan")
df = readr::read_csv(file)
#> Rows: 1440001 Columns: 4
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> dbl  (3): X, Y, Z
#> dttm (1): HEADER_TIMESTAMP
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
readr::stop_for_problems(df)
out = swan(df, sampling_rate = 80L)
#> Computing features...
#> 17:38:38 Performing window-level classification...
out$second_pass %>% dplyr::count(prediction)
#> # A tibble: 3 × 2
#>   prediction     n
#>   <chr>      <int>
#> 1 Nonwear      121
#> 2 Sleep        126
#> 3 Wear         353
## basic example code
```
