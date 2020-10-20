#'Summary_table
#'
#'@description Creates a styled and formatted table to represent the summary case situation of COVID19 COVID19 in each country.
#'
#'@param country The country data to be formatted in table such as Australia, China and United Kingdom.
#'
#'@return A formatted table of the data set will be displayed
#'
#'@importFrom magrittr %>%
#'
#'@export
summary_table<-function(country){
  covid19_count%>%
    dplyr::select(Type,Month,country,Cases)%>%
    dplyr::group_by(Type,Month,country) %>%
    dplyr::summarise(Cases = sum(Cases))%>%
    tidyr::pivot_wider(names_from = Type,
                       values_from = Cases)%>%
  dplyr::filter(country==country)%>%
    kableExtra::kable(col.names = c("Month", "Country", "Confirmed", "Death", "Recovered"),
                      align = "llrrr",
                      booktabs=TRUE,
                      caption = "summary statistic")%>%
    kableExtra::kable_styling(bootstrap_options = c("striped", "hover", "border"))%>%
    kableExtra::row_spec( 1:9,bold = T,color = "white",background = "#2875a1")
}