#Data Preprocessing
#1. filter observation
library(dplyr)
exam<-read.csv("csv_exam.csv"); exam

exam %>% filter(class==1) #pipe operator
exam %>% filter(class==2)
exam %>% filter(class!=1)
exam %>% filter(class!=3)
exam %>% filter(math>50)
exam %>% filter(math<50)
exam %>% filter(english>=80)
exam %>% filter(english<=80)

exam %>% filter(class==1 & math>=50)
exam %>% filter(class==2 & english>=80)
exam %>% filter(math>=90 | english>=90)
exam %>% filter(english<90 | science<50)
exam %>% filter(class==1 | class==3 | class==5)
exam %>% filter(class %in% c(1,3,5))

class1<-exam %>% filter(class==1)
class2<-exam %>% filter(class==2)
mean(class1$math)
mean(class2$math)

#과제1:
#mpg 데이터를 이용한다.
#1) 배기량이 4이하인 차고속도로 평균 연비, 5이상인 차의 고속도로 평균 연비를 출력한다.
#2) 배기량이 4이하인 차와, 5이상인 차 모두의 고속도로 평균 연비를 출력한다.
#3) 'audi'와 'toyota'중 어느 제조사의 도시평균연비가 높은 지 본다.
#4) 'chevrolet','ford','honda' 차들을 총해서 고속도로평균연비를 본다. 


#2. select variable
exam %>% select(math)
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math, -english)

exam %>% filter(class==1) %>% select(english)
exam %>% select(id, math) %>% head(3)

#과제2:
#1) mpg 데이터에서 class(자동차종류), cty(도시연비) 변수로 구성된 데이터를 만든다.
#2) 'suv','compact' 자동차의 도시연비를 비교한다.


#3. arrange
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

#과제3:
#audi에서 생산한 차 중에서 hwy가 높은 순 5위까지 출력한다.


#4. add derived variable
exam %>% mutate(total=math+english+science) %>% head
exam %>% mutate(total=math+english+science,
                mean=(math+english+science)/3) %>% head
exam %>% mutate(test=ifelse(science>=60, "pass", "false")) %>% head
exam %>% mutate(total=math+english+science) %>% arrange(total) %>% head

#과제4:
#1) mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비' 변수를 추가한다.
#2) '합산 연비' 변수를 2로 나눈 '평균 연비' 변수를 추가한다.
#3) '평균 연비' 값이 높은 순으로 자동차 3대를 출력한다.
#4) 1~3번 문제를 명령문 하나로 해결한다. 


#5. summarise
exam %>% summarise(meanMath=mean(math))
exam %>% group_by(class) %>% summarise(meanMath=mean(math))
exam %>% group_by(class) %>% summarise(mean=mean(math),
                                       sum=sum(math),
                                       median=median(math),
                                       n=n())
mpg %>% group_by(manufacturer, drv) %>% 
  summarise(meanCty=mean(cty)) %>% 
  head(10)

mpg %>%
  filter(class=="suv") %>% 
  mutate(avg=(cty+hwy)/2) %>%
  group_by(manufacturer) %>% 
  summarise(fuel.eco=mean(avg)) %>% 
  arrange(desc(fuel.eco)) %>% 
  head(5)

#과제5:
#1) mpg 데이터에서, class별 cty 평균을 구한다.
#2) 위 결과를 cty 평균 기준 내림차순으로 정렬한다.
#3) hwy 평균이 높은 회사 세 곳을 찾는다.
#4) 각 회사별 'compact' class 수를 내림차순으로 정렬한다.


#5. merge
test1<-data.frame(id=c(1,2,3,4,5),
                  midterm=c(60,80,70,90,85))
test2<-data.frame(id=c(1,2,3,4,5),
                  final=c(70,83,65,95,80))
test<-left_join(test1, test2, by="id"); test

exam<-read.csv("csv_exam.csv"); exam
name<-data.frame(class=c(1,2,3,4,5),
                 teacher=c("kim","lee","park","choi","jung")); name
exam<-left_join(exam, name, by="class"); exam

groupA<-data.frame(id=c(1,2,3,4,5),
                   test=c(60,80,70,90,85))
groupB<-data.frame(id=c(6,7,8,9,10),
                   test=c(70,83,65,95,80))
groupAll<-bind_rows(groupA, groupB); groupAll


#과제6:
# f1 flName   price
# c  CNG      2.35
# d  diesel   2.38
# e  ethanol  2.11
# p  premium  2.76
# r  regular  2.22
#
#1) 위 표로 구성된 data.frame 'fuel'을 만든다.
#2) 'fuel' 데이터를 mpg 데이터에 left_join 한다.
#3) mpg 에서, model, flName, price 변수만으로, 5개행을 조회한다.
#------------


#과제1:
#mpg 데이터를 이용한다.
mpg<-ggplot2::mpg
#1) 배기량이 4이하인 차고속도로 평균 연비, 5이상인 차의 고속도로 평균 연비를 출력한다.
displ4<-mpg %>% filter(displ<=4)
displ5<-mpg %>% filter(displ>=5)
mean(displ4$hwy); mean(displ5$hwy)

#2) 배기량이 4이하인 차와, 5이상인 차 모두의 고속도로 평균 연비를 출력한다.
mean(
  (mpg %>% filter(displ<=4 | displ>=5))$hwy
)

#3) 'audi'와 'toyota'중 어느 제조사의 도시평균연비가 높은 지 본다.
audi<-mpg %>% filter(manufacturer=='audi')
toyota<-mpg %>% filter(manufacturer=='toyota')
mean(audi$cty); mean(toyota$cty)

#4) 'chevrolet','ford','honda' 차들을 총해서 고속도로평균연비를 본다. 
car<-mpg %>% filter(manufacturer %in% c('chevrolet','ford','honda'))
mean(car$hwy)


#과제2:
#1) mpg 데이터에서 class(자동차종류), cty(도시연비) 변수로 구성된 데이터를 만든다.
mpg<- ggplot2::mpg %>% select(class,cty)
#2) 'suv','compact' 자동차의 도시연비를 비교한다.
mean((mpg %>% filter(class=='suv'))$cty)
compact<-mpg %>% filter(class=='compact'); mean(compact$cty)


#과제3:
#audi에서 생산한 차 중에서 hwy가 높은 순 5위까지 출력한다.
mpg<-ggplot2::mpg
mpg %>% filter(manufacturer=='audi') %>% arrange(desc(hwy)) %>% head(5)


#과제4:
#1) mpg 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비' 변수를 추가한다.
mpg<-ggplot2::mpg
mpg<-mpg %>% mutate(total=cty+hwy)
#2) '합산 연비' 변수를 2로 나눈 '평균 연비' 변수를 추가한다.
mpg<-mpg %>% mutate(avg=total/2)
#3) '평균 연비' 값이 높은 순으로 자동차 3대를 출력한다.
mpg %>% arrange(desc(avg)) %>% head(3)
#4) 1~3번 문제를 명령문 하나로 해결한다. 
mpg %>% mutate(total=cty+hwy,avg=total/2) %>% arrange(desc(avg)) %>% head(3)


#과제5:
#1) mpg 데이터에서, class별 cty 평균을 구한다.
mpg<-ggplot2::mpg
mpg %>% 
  group_by(class) %>% 
  summarise(ctyAvg=mean(cty))
#2) 위 결과를 cty 평균 기준 내림차순으로 정렬한다.
mpg %>% 
  group_by(class) %>% 
  summarise(ctyAvg=mean(cty)) %>% 
  arrange(desc(ctyAvg))
#3) hwy 평균이 높은 회사 세 곳을 찾는다.
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(hwyAvg=mean(hwy)) %>% 
  arrange(desc(hwyAvg)) %>% 
  head(3)
#4) 각 회사별 'compact' class 수를 내림차순으로 정렬한다.
mpg %>% 
  filter(class=='compact') %>% 
  group_by(manufacturer) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))


#과제6:
# f1 flName   price
# c  CNG      2.35
# d  diesel   2.38
# e  ethanol  2.11
# p  premium  2.76
# r  regular  2.22
#
#1) 위 표로 구성된 data.frame 'fuel'을 만든다.
fuel<-data.frame(fl=c("c","d","e","p","r"),
                 flName=c("CNG","diesel","ethanol","premium","regular"),
                 price=c(2.35, 2.38, 2.11, 2.76, 2.22),
                 stringsAsFactors=F)
#2) 'fuel' 데이터를 mpg 데이터에 left_join 한다.
mpg<-ggplot2::mpg
mpg<-left_join(mpg, fuel)
#3) mpg 에서, model, flName, price 변수만으로, 5개행을 조회한다.
mpg %>% select(model, flName, price) %>% head(5)