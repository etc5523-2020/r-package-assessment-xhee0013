#' Create input options for shiny app
#' 
#' @description Create the shiny input options for the different variables which are contained in the data sets.
#'
#' @param input The variable can be chosen for the input selection via `"country"`, `"province"`, or `"summary"`.
#' @param data The data set for the input to be used interactively via `covid19_count` or `covid19_region`.
#'
#' @return Using the input options in shiny app selection could be visualized the content more interactive.
#' 
#' @import shiny
#' 
#' @export
#'
input_option <- function(input, data){
  if(input == "country"){
    selectInput("country", "Which country do you want to examine?", 
                       choices = unique(data$country),
                       selected = "China")
  } else if(input == "province"){
    selectInput("province", "Which province?", choices = "")
  } else if(input == "summary"){
    radioButtons("comparison_summary", h3("Select country:"),
                         choices =unique(data$country))
  }
}