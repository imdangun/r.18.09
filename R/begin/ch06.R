#1. refine NA(Not Available)
game<-data.frame(gender=c("M","F",NA,"M","F"),
                 score=c(5,4,3,4,NA))
is.na(game)
table(is.na(game))
table(is.na(game$gender))
table(is.na(game$score))
sum(game$score) # NA
 
library(dplyr)
game %>% filter(is.na(score))
game %>% filter(!is.na(score))
game2<-game %>% filter(!is.na(score))
sum(game2$score)
 
game3<-game %>% filter(!is.na(score) & !is.na(gender))
game3
 
game4<-na.omit(game); game4
 
mean(game$score, na.rm=T)
sum(game$score, na.rm=T)
 
exam<-read.csv("csv_exam.csv")
exam[c(3,8,15), "math"]<-NA; exam
exam %>% summarise(meanMath=mean(math))#NA
exam %>% summarise(meanMath=mean(math, na.rm=T))
exam %>% summarise(meanMath=mean(math, na.rm=T),
                   sumMath=sum(math, na.rm=T),
                   medianMath=median(math, na.rm=T))
 
mean(exam$math, na.rm=T)
table(is.na(exam$math))
exam$math<-ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))
exam[c(3,8,15), "math"]
 
#과제1:
mpg<-ggplot2::mpg
mpg[c(65,124,131,153,212),"hwy"]<-NA
#1) drv, hwy 변수에 NA가 몇개 있는 지 알아본다.
#2) filter()를 이용해 hwy 의 NA를 제외한다. hwy 평균이 가장 높은 drv를 찾는다.
 
 
#2. refine outlier
outlier<-data.frame(gender=c(1,2,1,3,2,1),
                    score=c(5,4,3,4,2,6)); outlier
table(outlier$gender)
outlier$gender<-ifelse(outlier$gender==3, NA, outlier$gender); outlier
outlier$score<-ifelse(outlier$score>5, NA, outlier$score); outlier
 
outlier %>% 
  filter(!is.na(gender) & !is.na(score)) %>%
  group_by(gender) %>% 
  summarise(scoreAvg=mean(score))
 
box<-boxplot(mpg$hwy); box
box$stats
 
mpg$hwy<-ifelse(mpg$hwy<12 | mpg$hwy>37, NA, mpg$hwy)
table(is.na(mpg$hwy))
 
mpg %>% 
  group_by(drv) %>% 
  summarise(hwyAvg=mean(hwy, na.rm=T))
 
#과제2:
mpg<-ggplot2::mpg
mpg[c(10,14,58,93), "drv"]<-"k"
mpg[c(29,43,129,203), "cty"]<-c(3,4,39,42)
#1) drv에 이상치가 있으면 NA 를 할당한다.
#2) boxplot을 이용해 cty에 이상치가 있는지 확인한다.
#3) drv별로 cty 평균을 구한다.
#---------
 
 
#과제1:
mpg<-ggplot2::mpg
mpg[c(65,124,131,153,212),"hwy"]<-NA
#1) drv, hwy 변수에 NA가 몇개 있는 지 알아본다.
table(is.na(mpg$drv))
table(is.na(mpg$hwy))
#2) filter()를 이용해 hwy 의 NA를 제외한다. hwy 평균이 가장 높은 drv를 찾는다.
mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(hwyAvg=mean(hwy)) %>% 
  arrange(desc(hwyAvg)) %>% 
  head(1)
 
 
#과제2:
mpg<-ggplot2::mpg
mpg[c(10,14,58,93), "drv"]<-"k"
mpg[c(29,43,129,203), "cty"]<-c(3,4,39,42)
#1) drv에 이상치가 있으면 NA 를 할당한다.
table(mpg$drv)
mpg$drv<-ifelse(mpg$drv %in% c("4","f","r"), mpg$drv, NA)
#2) boxplot을 이용해 cty에 이상치가 있는지 확인한다.
boxplot(mpg$cty)$stats
mpg$cty<-ifelse(mpg$cty<9 | mpg$cty>26, NA, mpg$cty)
boxplot(mpg$cty)
#3) drv별로 cty 평균을 구한다.
mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(ctyMean=mean(cty))