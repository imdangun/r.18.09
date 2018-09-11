#1. scater plot
library(ggplot2)
ggplot(data=mpg, aes(x=displ, y=hwy))
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()+xlim(3,6)
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()+xlim(3,6)+ylim(10,30)

#과제1:
#1) mpg에서, x축 cty, y축 hwy로 산점도를 만든다.
#2) ggplot2::midwest에서, x축 poptotal, y축 popasian로 산점도를 만든다.
#   poptotal은 50만명 이하, popasian은 1만명 이하인 지역만 표시한다.


#2. bar chart
library(dplyr)
mpg2<-mpg %>% group_by(drv) %>% summarise(meanHwy=mean(hwy))
ggplot(data=mpg2, aes(x=drv, y=meanHwy))+geom_col()
ggplot(data=mpg2, aes(x=reorder(drv, -meanHwy), y=meanHwy))+geom_col()

ggplot(data=mpg, aes(x=drv))+geom_bar()

#과제2:
#1) 'suv' 차종을 대상으로 평균 cty가 높은 회사 다섯 곳을 찾는다.
#   연비 기준 내림차순으로 정렬하여 막대 그래프를 그린다.
#2) class별 빈도를 막대그래프로 표현한다.


#3. line chart (Time Series Chart)
ggplot(data=economics, aes(x=date, y=unemploy))+geom_line()


#4. box plot(분포)
ggplot(data=mpg, aes(x=drv, y=hwy))+geom_boxplot()

#과제3:
# class가 'compact','subcompact','suv'인 자동차의 cty를 boxplot으로 비교한다.
#----------


#과제1:
#1) mpg에서, x축 cty, y축 hwy로 산점도를 만든다.
ggplot(data=mpg, aes(x=cty, y=hwy))+geom_point()
#2) ggplot2::midwest에서, x축 poptotal, y축 popasian로 산점도를 만든다.
#   poptotal은 50만명 이하, popasian은 1만명 이하인 지역만 표시한다.
ggplot(data=midwest, aes(x=poptotal, y=popasian))+
  geom_point()+xlim(0,500000)+ylim(0,10000)


#과제2:
#1) 'suv' 차종을 대상으로 평균 cty가 높은 회사 다섯 곳을 찾는다.
#   연비 기준 내림차순으로 정렬하여 막대 그래프를 그린다.
mpg2<-mpg %>% filter(class=='suv') %>% 
  group_by(manufacturer) %>% summarise(meanCty=mean(cty)) %>% 
  arrange(desc(meanCty)) %>% head(5)
ggplot(data=mpg2, aes(x=reorder(manufacturer, -meanCty), y=meanCty))+geom_col()
#2) class별 빈도를 막대그래프로 표현한다.
ggplot(data=mpg, aes(x=class))+geom_bar()


#과제3:
# class가 'compact','subcompact','suv'인 자동차의 cty를 boxplot으로 비교한다.
mpg2<-mpg %>% filter(class %in% c("compact","subcompact","suv"))
ggplot(data=mpg2, aes(x=class, y=cty))+geom_boxplot()