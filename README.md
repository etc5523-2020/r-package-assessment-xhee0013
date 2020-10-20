
<!-- README.md is generated from README.Rmd. Please edit that file -->

# covid19tracker

<!-- badges: start -->

<!-- badges: end -->

The goal of covid19tracker is to interactively visualize the situation
of COVID-19 cases in three countries from January to September and
provide a platform for performing and reviewing the change of cases
distribution for each regions in all countries.

## Installation

You can install the released version of covid19tracker from
[Github](https://github.com/etc5523-2020/r-package-assessment-xhee0013)
with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-xhee0013")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(covid19tracker)
library(tibble)
covid19_count
#> # A tibble: 1,395 x 7
#>    Type      province Month country         long   lat Cases
#>    <chr>     <chr>    <dbl> <chr>          <dbl> <dbl> <int>
#>  1 confirmed Anguilla     1 United Kingdom -63.1  18.2     0
#>  2 confirmed Anguilla     2 United Kingdom -63.1  18.2     0
#>  3 confirmed Anguilla     3 United Kingdom -63.1  18.2     2
#>  4 confirmed Anguilla     4 United Kingdom -63.1  18.2     1
#>  5 confirmed Anguilla     5 United Kingdom -63.1  18.2     0
#>  6 confirmed Anguilla     6 United Kingdom -63.1  18.2     0
#>  7 confirmed Anguilla     7 United Kingdom -63.1  18.2     0
#>  8 confirmed Anguilla     8 United Kingdom -63.1  18.2     0
#>  9 confirmed Anguilla     9 United Kingdom -63.1  18.2     0
#> 10 confirmed Anhui        1 China          117.   31.8   237
#> # … with 1,385 more rows
```

``` r
covid19_region
#> # A tibble: 51 x 6
#>    type      country   province                      long   lat Cases
#>    <chr>     <chr>     <chr>                        <dbl> <dbl> <int>
#>  1 confirmed Australia Australian Capital Territory  149. -35.5   113
#>  2 confirmed Australia New South Wales               151. -33.9  4185
#>  3 confirmed Australia Northern Territory            131. -12.5    33
#>  4 confirmed Australia Queensland                    153. -27.5  1149
#>  5 confirmed Australia South Australia               139. -34.9   466
#>  6 confirmed Australia Tasmania                      147. -42.9   230
#>  7 confirmed Australia Victoria                      145. -37.8 19943
#>  8 confirmed Australia Western Australia             116. -32.0   659
#>  9 confirmed China     Anhui                         117.  31.8   991
#> 10 confirmed China     Beijing                       116.  40.2   935
#> # … with 41 more rows
```

<!-- What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so: -->

<!-- ```{r cars} -->

<!-- summary(cars) -->

<!-- ``` -->

<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. -->

<!-- You can also embed plots, for example: -->

<!-- ```{r pressure, echo = FALSE} -->

<!-- plot(pressure) -->

<!-- ``` -->

<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub! -->
