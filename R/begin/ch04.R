#1. data 파악하기
exam<-read.csv("csv_exam.csv")
head(exam)
head(exam,10)
tail(exam)
tail(exam,10)

View(exam)
dim(exam)
str(exam)
summary(exam)

library(ggplot2)
mpg<-ggplot2::mpg
head(mpg)
tail(mpg)
dim(mpg)
str(mpg)
?mpg
summary(mpg)


#2. 변수명 바꾸기
nums<-data.frame(var1=c(1,2,1), var2=c(2,3,2))
nums
library(dplyr)
nums2<-nums; nums2
nums2<-rename(nums2, v2=var2); nums2

#과제1:
#1) ggplot2::mpg 데이터를 불러온다.
#2) cty는 city로, hwy는 highway로 변수명을 바꾼다.
#3) mpg 데이터 일부를 출력해 바뀐 변수명을 확인한다.


#3. Derived Variable
nums<-data.frame(var1=c(4,3,8), var2=c(2,6,1)); nums
nums$sum<-nums$var1+nums$var2; nums
nums$mean<-(nums$var1+nums$var2)/2; nums

mpg<-as.data.frame(ggplot2::mpg)
mpg$gasMileage<-(mpg$cty+mpg$hwy)/2
head(mpg)
mean(mpg$gasMileage)

summary(mpg$gasMileage)
hist(mpg$gasMileage)
mpg$test<-ifelse(mpg$gasMileage>=20, "pass", "fail")
head(mpg, 20)
table(mpg$test)
library(ggplot2)
qplot(mpg$test)

mpg$grade<-ifelse(mpg$gasMileage>=30,"A",
                  ifelse(mpg$gasMileage>=20,"B","C"))
head(mpg$grade,20)
table(mpg$grade)
qplot(mpg$grade)


#과제2:
#1) ggplot2::midwest 데이터를 data.frame 으로 불러와서, 구조를 파악한다.
#2) poptotal을 total로, popasian을 asisan으로 변수명을 변경한다.
#3) total, asian을 이용해, '전체 인구 대비 아시아 인구율' 변수를 만든다. 
#   히스토그램으로 도시 분포를 살펴본다.
#4) 아시아 인구율 전체 평균을 구한다. 
#   평균 초과는 'large', 평균 이하는 'small' 값을 가지는 변수를 만든다.
#5) 'large''small'에 해당하는 지역의 빈도표, 빈도 막대 그래프를 만든다.
#-----------


#과제1:
#1) ggplot2::mpg 데이터를 불러온다.
mpg<-ggplot2::mpg
#2) cty는 city로, hwy는 highway로 변수명을 바꾼다.
mpg<-rename(mpg, city=cty, highway=hwy)
#3) mpg 데이터 일부를 출력해 바뀐 변수명을 확인한다.
head(mpg)


#과제2:
#1) ggplot2::midwest 데이터를 data.frame 으로 불러와서, 구조를 파악한다.
midwest<-as.data.frame(ggplot2::midwest)
#2) poptotal을 total로, popasian을 asian으로 변수명을 변경한다.
library(dplyr)
midwest<-rename(midwest, total=poptotal, asian=popasian)
#3) total, asian을 이용해, '전체 인구 대비 아시아 인구 백분율' 변수를 만든다. 
#   히스토그램으로 도시 분포를 살펴본다.
midwest$asianPct<-midwest$asian/midwest$total*100
head(midwest$asianPct)
hist(midwest$asianPct)
#4) 아시아 인구율 전체 평균을 구한다. 
#   평균 초과는 'large', 평균 이하는 'small' 값을 가지는 변수를 만든다.
asianMean<-mean(midwest$asianPct); asianMean
midwest$vol<-ifelse(midwest$asianPct>asianMean, "large", "small")
head(midwest$vol)
#5) 'large''small'에 해당하는 지역의 빈도표, 빈도 막대 그래프를 만든다.
table(midwest$vol)
hist(midwest$vol)
library(ggplot2)
qplot(midwest$vol)
