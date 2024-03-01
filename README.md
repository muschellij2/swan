
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
#> 21:55:23 Performing window-level classification...
head(out$first_pass)
#> # A tibble: 6 × 23
#>   header_time_stamp   predicted x_domfreq y_domfreq z_domfreq x_domfreq_power
#>   <dttm>                  <dbl>     <dbl>     <dbl>     <dbl>           <dbl>
#> 1 2000-01-10 15:00:00         2    0         0        20              0      
#> 2 2000-01-10 15:00:30         2    0         0        20              0      
#> 3 2000-01-10 15:01:00         2    0         0        20              0      
#> 4 2000-01-10 15:01:30         2    0         0        20              0      
#> 5 2000-01-10 15:02:00         0    9.37      9.63      0.0333         0.00472
#> 6 2000-01-10 15:02:30         1    0.0333    0.0333    0.0333         0.00162
#> # ℹ 17 more variables: y_domfreq_power <dbl>, z_domfreq_power <dbl>,
#> #   x_totpow <dbl>, y_totpow <dbl>, z_totpow <dbl>, ori_x_median <dbl>,
#> #   ori_y_median <dbl>, ori_z_median <dbl>, ori_var_sum <dbl>,
#> #   ori_range_max <dbl>, smv_energy_sum <dbl>, smv_energy_var <dbl>,
#> #   start_time <dttm>, stop_time <dttm>, prob_wear <dbl>, prob_sleep <dbl>,
#> #   prob_nwear <dbl>
head(out$second_pass)
#> # A tibble: 6 × 27
#>   header_time_stamp   predicted prediction x_domfreq y_domfreq z_domfreq
#>   <dttm>                  <dbl> <chr>          <dbl>     <dbl>     <dbl>
#> 1 2000-01-10 15:00:00         1 Sleep         0         0        20     
#> 2 2000-01-10 15:00:30         1 Sleep         0         0        20     
#> 3 2000-01-10 15:01:00         1 Sleep         0         0        20     
#> 4 2000-01-10 15:01:30         1 Sleep         0         0        20     
#> 5 2000-01-10 15:02:00         0 Sleep         9.37      9.63      0.0333
#> 6 2000-01-10 15:02:30         1 Sleep         0.0333    0.0333    0.0333
#> # ℹ 21 more variables: x_domfreq_power <dbl>, y_domfreq_power <dbl>,
#> #   z_domfreq_power <dbl>, x_totpow <dbl>, y_totpow <dbl>, z_totpow <dbl>,
#> #   ori_x_median <dbl>, ori_y_median <dbl>, ori_z_median <dbl>,
#> #   ori_var_sum <dbl>, ori_range_max <dbl>, smv_energy_sum <dbl>,
#> #   smv_energy_var <dbl>, start_time <dttm>, stop_time <dttm>, prob_wear <dbl>,
#> #   prob_sleep <dbl>, prob_nwear <dbl>, prob_wear_smooth <list>,
#> #   prob_sleep_smooth <list>, prob_nwear_smooth <list>
out$second_pass %>% dplyr::count(prediction)
#> # A tibble: 3 × 2
#>   prediction     n
#>   <chr>      <int>
#> 1 Nonwear      121
#> 2 Sleep        126
#> 3 Wear         353
## basic example code
```
