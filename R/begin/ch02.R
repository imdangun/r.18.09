#1. 변수
a<-1; a
b<-2; b
c<-3; c
d<-3.5; d
a+b
a+b+c
4/b
5*b

var1<-c(1,2,5,7,8); var1
var2<-c(1:5); var2
var3<-seq(1,5); var3
var4<-seq(1,10,by=2); var4
var5<-seq(1,10,by=3); var5

var1+2
var1+var2

str1<-"a"; str1
str2<-"text"; str2
str3<-"My Apple"; str3
str4<-c("a","b","c"); str4
str5<-c("My","apple","is","good"); str5
str1+2 #error


#2. function
x<-c(1,2,3)
mean(x)
max(x)
min(x)
paste(str5, collapse=",")
paste(str5, collapse=" ")

xMean<-mean(x); xMean
str5Paste<-paste(str5, collapse=" "); str5Paste

#과제1:
#1) 10,20,30,40,50 다섯개 점수를 담은 변수를 만들고, 출력한다.
#2) 위 다섯개 점수의 평균 점수를 변수에 저장하고, 출력한다.


#3. package
install.packages("ggplot2")
library(ggplot2)
x<-c("a","a","b","c"); x
qplot(x)
str(mpg)
qplot(data=mpg, x=hwy)
qplot(data=mpg, x=cty)
qplot(data=mpg, x=drv, y=hwy)
qplot(data=mpg, x=drv, y=hwy, geom="line")
qplot(data=mpg, x=drv, y=hwy, geom="boxplot")
qplot(data=mpg, x=drv, y=hwy, geom="boxplot", colour=drv)
?qplot
----------
  
  
#과제1:
#1) 10,20,30,40,50 다섯개 점수를 담은 변수를 만들고, 출력한다.
score=c(10,20,30,40,50); scores
#2) 위 다섯개 점수의 평균 점수를 변수에 저장하고, 출력한다.
avg=mean(score); avg
