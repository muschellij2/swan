
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

This is a basic example which shows you how to solve a common problem:

``` r
library(swan)
## basic example code
```
