#1. data.frame 만들기
english<-c(90,80,60,70); english
math<-c(50,60,100,20); math
midterm<-data.frame(english, math); midterm
class<-c(1,1,2,2); class
midterm<-data.frame(english, math, class); midterm
mean(midterm$english)
mean(midterm$math)
midterm<-data.frame(english=c(90,80,60,70),
                    math=c(50,60,100,20),
                    class=c(1,1,2,2))
midterm

#과제1:
#1) 다음 내용의 data.frame 을 만든다.
       # 제품     가격     판매량
       # 사과     1800      24
       # 딸기     1500      38
       # 수박     3000      13
#2) 과일 가격 평균, 판매량 평균을 구한다.


#2. 외부 데이터 이용하기
library(readxl)
exam<-read_excel("excel_exam.xlsx", sheet=1)
str(exam)
mean(exam$english)
mean(exam$science)

csvExam<-read.csv("csv_exam.csv", stringsAsFactors=F)
write.csv(midterm, file="midterm.csv")

save(midterm, file="midterm.rda")
rm(midterm)
load("midterm.rda")
#--------------


#과제1:
#1) 다음 내용의 data.frame 을 만든다.
# 제품     가격     판매량
# 사과     1800      24
# 딸기     1500      38
# 수박     3000      13
sales<-data.frame(name=c("사과","딸기","수박"),
                  price=c(1800,1500,3000),
                  volume=c(24,38,13))
#2) 과일 가격 평균, 판매량 평균을 구한다.
priceAvg<-mean(sales$price); priceAvg
volumeAvg<-mean(sales$volume); volumeAvg

