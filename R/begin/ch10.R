install.packages("ggiraphExtra")
install.packages("maps")
install.packages("mapproj")
library(ggiraphExtra)
library(tibble)
library(ggplot2)
library(maps)
library(mapproj)

#1. 강력범죄율~미국주
str(USArrests)
head(USArrests)
crime<-rownames_to_column(USArrests, var="state")
head(crime)
crime$state<-tolower(crime$state)
head(crime)
str(crime)

states<-map_data("state")
str(states)

ggChoropleth(data=crime,
             aes(fill=Murder, map_id=state),
             map=states)


#2. 인구~대한민국 시도별
install.packages("stringi")
install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014") #In R CMD INSTALL
library(kormaps2014)
library(dplyr)

str(korpop1)
str(changeCode(korpop1)) #changeCode(): utf-8->cp949
korpop1<-rename(korpop1, pop="총인구_명", name="행정구역별_읍면동")

options(encoding="utf-8")
ggChoropleth(data=korpop1,
             aes(fill=pop,
                 map_id=code,
                 tooltip=name),
             map=kormap1,
             interactive=T)

install.packages("caTools") # save as webpage
