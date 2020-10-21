#' @title COVID-19 case numbers in each region
#'
#' @description This data set shows the cumulative COVID19 confirmed cases for each region in three countries.
#' 
#' @format a tibble with 51 observations and 6 variables 
#' 
#' - **Type**: COVID19 confirmed cases.
#' - **province**: Name of province/state, for countries. 
#' - **Country**: Name of country/region. 
#' - **long**: Longitude of center of geographic region.
#' - **lat**:Latitude of center of geographic region.
#' - **Cases**:Number of confirmed cases on given region.
#'
#' @import tibble
#' 
#' @source [Coronavirus Github](https://github.com/RamiKrispin/coronavirus)

"covid19_region"