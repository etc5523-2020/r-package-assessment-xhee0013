#' @title 
#' Running Shiny App of COVID19 tracker
#' 
#' @description 
#' This function will launch shiny app where users can explore the case situation of Covid-19 for each region in three countries.
#' 
#' @import shiny
#' 
#' @examples
#' \dontrun{
#' launch_app()
#' }
#' 
#' 
#' @export
launch_app <- function(){
  appDir <- system.file( "app", package = "covid19tracker")
  
  if (appDir==""){
    stop("Could not find example directory. Try re-installed `covid19tracker` package")
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}