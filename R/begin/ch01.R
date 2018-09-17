install.packages("tidyverse")
library(tidyverse)
 
exam<-read.csv("csv_exam.csv")
class(exam)
 
#1. R내장함수
#filtering
exam[]
exam[1,]
exam[2,]
exam[exam$class==1,]
exam[exam$math>=80,]
exam[exam$class==1 & exam$math>=50,]
exam[exam$english<90 | exam$science<50,]
 
#selection
exam[,1]
exam[,2]
exam[,3]
exam[,"class"]
exam[,"math"]
exam[,c("class","math","english")]
 
exam[1,3]
exam[5,"english"]
exam[exam$math>=50, c("english","science")]
 
 
#수학50점이상, 영어80점이상인 학생들만으로, 각 반의 전 과목 평균을 구한다.
exam$avg<-(exam$math+exam$english+exam$science)/3
head(exam[])
aggregate(data=exam[exam$math>=50 & exam$english>=80,], avg~class, mean)
aggregate(data=exam[exam$math>=50 & exam$english>=80,], avg~class, sum)
 
exam %>%
  filter(math>=50 & english>=80) %>%
  mutate(avg=(math+english+science)/3) %>%
  group_by(class) %>%
  summarise(mean=mean(avg))
 
#과제1:
#'compact'과 'suv'차종의 '도시 및 고속도로 연비 평균'을 구하는 코드이다.
#이 코드를 aggregate() 함수를 이용하는 걸로 refactoring 한다.
mpg<-ggplot2::mpg
mpg %>%
  filter(class=="compact" | class=="suv") %>%
  mutate(avg=(cty+hwy)/2) %>%
  group_by(class) %>%
  summarise(mean=mean(avg))
 
 
#2. DataType
#Continuous Variable: numeric
#Categorical Variable: factor
var1<-c(1,2,3,1,2)
var2<-factor(c(1,2,3,1,2))
var1
var2
var1+1
var2+1 #error
class(var1)
class(var2)
levels(var1)
levels(var2)
var3<-c("a","b","b","c")
var4<-factor(c("a","b","b","c"))
var3
var4
class(var3)
class(var4)
mean(var1)
mean(var2) #error
var2<-as.numeric(var2)
mean(var2)
class(var2)
levels(var2)
#as.numeric(), as.factor(), as.character(), as.Date(), as.data.frame()
#numeric, integer, complex, character, logical, factor, Date
 
#과제2:
#1) mpg$drv 변수의 데이터타입을 확인한다.
#2) drv 변수를 factor 타입으로 변환한다.
#3) drv 범주를 확인한다.
 
 
#3. Data Structure
#vector, data.frame, matrix, array, list
 
#vector
a<-1; a
b<-"hello"; b
class(a)
class(b)
 
#data.frame
x1<-data.frame(var1=c(1,2,3), var2=c("a","b","c"))
class(x1)
 
#matrix
x2<-matrix(c(1:12), ncol=2)
x2
class(x2)
 
#array
x3<-array(1:20, dim=c(2,5,2))
x3
class(x3)
 
#list
x4<-list(f1=a, f2=x1, f3=x2, f4=x3) #vector,data.frame,matrix,array
x4
class(x4)
 
mpg<-ggplot2::mpg
class(mpg)
x<-boxplot(mpg$cty)
x
x$stats[,1]
x$stats[,1][3]
x$stats[,1][2]
#-----------
 
 
#과제1:
#'compact'과 'suv'차종의 '도시 및 고속도로 연비 평균'을 구하는 코드이다.
#이 코드를 aggregate() 함수를 이용하는 걸로 refactoring 한다.
mpg$avg<-(mpg$cty+mpg$hwy)/2
aggregate(data=mpg[mpg$class=="compact" | mpg$class=="suv",], avg~class, mean)
 
#과제2:
#1) mpg$drv 변수의 데이터타입을 확인한다.
class(mpg$drv)
#2) drv 변수를 factor 타입으로 변환한다.
mpg$drv<-factor(mpg$drv)
class(mpg$drv)
#3) drv 범주를 확인한다.
levels(mpg$drv)