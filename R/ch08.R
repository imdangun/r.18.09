load(file="welfare.rda")
head(welfare)

#1. 월급~성별
class(welfare$gender)
table(welfare$gender)
welfare$gender<-ifelse(welfare$gender==1,"male","female")
table(welfare$gender)
qplot(welfare$gender)

class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income)+xlim(0,1000)

welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
table(is.na(welfare$income))

genIncome<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(meanIncome=mean(income))
genIncome

ggplot(data=genIncome, aes(x=gender, y=meanIncome))+geom_col()


#2. 월급~나이
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)
table(is.na(welfare$birth))

welfare$age<-2015-welfare$birth+1 # 2015년 자료이다.
summary(welfare$age)
qplot(welfare$age)

ageIncome<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(meanIncome=mean(income))
head(ageIncome)

ggplot(data=ageIncome, aes(x=age, y=meanIncome))+geom_line()


#3. 월급~세대
welfare<-welfare %>% 
  mutate(generation=ifelse(age<30,"young", ifelse(age<60,"middle", "old")))
table(welfare$generation)
qplot(welfare$generation)

#1번 예제와 연속해서 실습하지 않을 경우에, 실행한다.
welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

genIncome<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(generation) %>% 
  summarise(meanIncome=mean(income))

ggplot(data=genIncome, aes(x=generation, y=meanIncome))+
  geom_col()+scale_x_discrete(limits=c("young","middle","old"))


#4. 월급~세대 및 성별
genIncome<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(generation, gender) %>% 
  summarise(meanIncome=mean(income))
genIncome                              

ggplot(data=genIncome, aes(x=generation, y=meanIncome, fill=gender))+
  geom_col()+scale_x_discrete(limits=c("young","middle","old"))

ggplot(data=genIncome, aes(x=generation, y=meanIncome, fill=gender))+
  geom_col(position="dodge")+
  scale_x_discrete(limits=c("young","middle","old"))

ageGenIncome<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, gender) %>% 
  summarise(meanIncome=mean(income))
head(ageGenIncome)

ggplot(data=ageGenIncome, aes(x=age, y=meanIncome, col=gender))+geom_line()


#5. 월급~직업
class(welfare$code_job)
table(welfare$code_job)
library(readxl)
jobs<-read_excel("Koweps_Codebook.xlsx", col_names=T, sheet=2)
head(jobs)
dim(jobs)

welfare<-left_join(welfare, jobs, id="code_job")

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

#3번 예제와 연속해서 실습하지 않을 경우에, 실행한다.
welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

jobIncome<-welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(meanIncome=mean(income))
head(jobIncome)
