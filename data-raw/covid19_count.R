## code to prepare `covid19_count` dataset goes here

library(coronavirus)
library(lubridate)
library(tidyverse)
data("coronavirus")
coronavirus %>%
  filter(country %in% c("Australia","United Kingdom","China"))%>%
  mutate(Month=month(date))%>%
  group_by(type,province,Month,country,long,lat) %>%
  summarise(Cases = sum(cases),.groups = 'drop')%>%
  rename(Type=type)->covid19_count
covid19_count<-covid19_count[-c(1:9),]

usethis::use_data(covid19_count, overwrite = TRUE)
