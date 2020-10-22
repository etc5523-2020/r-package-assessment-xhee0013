## code to prepare `covid19_region` dataset goes here

library(coronavirus)
library(lubridate)
library(tidyverse)


covid19_region<-coronavirus %>%
  filter(country %in% c("Australia","United Kingdom","China"))%>%
  mutate(Month=month(date))%>%
  group_by(type,country,province,long,lat) %>%
  summarise(Cases = sum(cases),.groups = 'drop')%>%
  filter(type=="confirmed")
covid19_region <- covid19_region[-c(42),]

usethis::use_data(covid19_region, overwrite = TRUE)
