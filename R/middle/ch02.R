#ch02. descriptive statistics
#1. graph
#1) plot(산점도)
str(cars)
plot(cars$speed, cars$dist,
     main="속도와제동거리", xlab="속도(mph)", ylab="제동거리(ft)",
     pch=1,col="red")

str(Nile)
plot(Nile, main="Nile강의 연도별 유량 변화", xlab="연도", ylab="유량")


#2) barplot(막대그래프), histogram
load("population.rda")
babyCnt<-table(data$V5)
babyCnt #table
barplot(babyCnt, main="출생아수별빈도", xlab="출생아수", ylab="빈도")

gender.school<-table(data$V1, data$V4)
gender.school #matrix
barplot(gender.school, legend.text=T, col=c("orange","green"),
        main="학력에따른성별인원수", xlab="학력", ylab="빈도", beside=T)
barplot(gender.school, legend.text=T, col=c("orange","green"),
        main="학력에따른성별인원수", xlab="학력", ylab="빈도")

hist(data$V2, main="연령별분포", xlab="연령", ylab="빈도")
hist(data$V2, breaks=c(seq(0,90,10)), right=F, #미만
     main="연령별분포", xlab="연령", ylab="빈도")


#3) pie-chart
school<-table(data$V4)
school
pie(school, main="학력별 비중")


#2. 
# 자료의 특성: 1)max/min,  2)mode,  3)mean, midian,  4)standard deviation
height<-c(164,166,168,170,172,174,176)
max(height)
min(height)
stem(height)
height.mean<-mean(height); height.mean
height.dev<-height-height.mean; height.dev #deviation(편차)
sum(height.dev)
variance<-mean(height.dev^2); variance #variance(분산)
sqrt(variance) #standard deviation(표준편차)

var(height) #variance
sd(height)  #standard deviation

qs<-quantile(height); qs
qs[4]-qs[2]
IQR(qs) # inter quartile range (사분위수 범위:1분위수~3분위수)
