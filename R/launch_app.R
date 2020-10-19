#' @title 
#' Running Shiny App of COVID19 tracker
#' 
#' @description 
#' This function will launch shiny app where users can explore the case situation of Covid-19 for each region in three countries.
#' 
#' @import shiny
#' 
#' @export
launch_app <- function(){
  shiny::runApp("inst/app/app.R")
}