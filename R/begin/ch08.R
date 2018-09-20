load(file="welfare.rda")

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

income.gender<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(meanIncome=mean(income)); income.gender

ggplot(data=income.gender, aes(x=gender, y=meanIncome))+geom_col()


#2. 월급~나이
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

table(is.na(welfare$birth))
welfare$age<-2015-welfare$birth+1 # 2015년 자료이다.
summary(welfare$age)
qplot(welfare$age)

income.age<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(meanIncome=mean(income)); head(income.age)

ggplot(data=income.age, aes(x=age, y=meanIncome))+geom_line()


#3. 월급~세대
welfare<-welfare %>% 
  mutate(generation=ifelse(age<30,"young", ifelse(age<60,"middle", "old")))
table(welfare$generation)
qplot(welfare$generation)

income.generation<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(generation) %>% 
  summarise(meanIncome=mean(income))

ggplot(data=income.generation, aes(x=generation, y=meanIncome))+
  geom_col()+scale_x_discrete(limits=c("young","middle","old"))
ggplot(data=income.generation, aes(x=generation, y=meanIncome))+
  geom_col()+scale_x_discrete(limits=c("old","middle","young"))
  

#4. 월급~세대 및 성별
income.generationGender<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(generation, gender) %>% 
  summarise(meanIncome=mean(income)); income.generationGender                             

ggplot(data=income.generationGender, aes(x=generation, y=meanIncome, fill=gender))+
  geom_col()+scale_x_discrete(limits=c("young","middle","old"))

ggplot(data=income.generationGender, aes(x=generation, y=meanIncome, fill=gender))+
  geom_col(position="dodge")+
  scale_x_discrete(limits=c("young","middle","old"))

income.ageGender<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, gender) %>% 
  summarise(meanIncome=mean(income)); head(income.ageGender)

ggplot(data=income.ageGender, aes(x=age, y=meanIncome, col=gender))+geom_line()


#5. 월급~직업
class(welfare$code_job)
table(welfare$code_job)
library(readxl)
jobs<-read_excel("welfare.xlsx", col_names=T, sheet=2)
head(jobs)
dim(jobs)

welfare<-left_join(welfare, jobs, id="code_job")
head(welfare[,c("code_job", "job")])
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

welfare$income<-ifelse(welfare$income %in% c(0,9999), NA, welfare$income)

income.job<-welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(meanIncome=mean(income)); head(income.job)

top10<-income.job %>% 
  arrange(desc(meanIncome)) %>% 
  head(10); top10
ggplot(data=top10, aes(x=reorder(job, meanIncome), y=meanIncome))+
  geom_col()+coord_flip()

bottom10<-income.job %>% 
  arrange(meanIncome) %>% 
  head(10)
ggplot(data=bottom10, aes(x=reorder(job, -meanIncome), y=meanIncome))+
  geom_col()+coord_flip()+ylim(0,850)


#6. 직업~성별
jobMale<-welfare %>% 
  filter(!is.na(job) & gender=="male") %>% 
  group_by(job) %>% 
  summarise(cnt=n()) %>% 
  arrange(desc(cnt)) %>% 
  head(10)
jobMale

jobFemale<-welfare %>% 
  filter(!is.na(job) & gender=="female") %>% 
  group_by(job) %>% 
  summarise(cnt=n()) %>% 
  arrange(desc(cnt)) %>% 
  head(10)
jobFemale

ggplot(data=jobMale, aes(x=reorder(job,cnt), y=cnt))+
  geom_col()+coord_flip()
ggplot(data=jobFemale, aes(x=reorder(job,cnt), y=cnt))+
  geom_col()+coord_flip()


#7. 이혼~종교
class(welfare$religion)
table(welfare$religion)
welfare$religion<-ifelse(welfare$religion==1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

class(welfare$marriage)
table(welfare$marriage)
welfare$marriage<-ifelse(welfare$marriage==1, "marriage",
                          ifelse(welfare$marriage==3, "divorce", NA))
table(welfare$marriage)
table(is.na(welfare$marriage))                          
qplot(welfare$marriage)

relMarriage<-welfare %>% 
  filter(!is.na(marriage)) %>% 
  count(religion, marriage) %>% 
  group_by(religion) %>% 
  mutate(pct=round(n/sum(n)*100, 1))
relMarriage

divorce<-relMarriage %>% 
  filter(marriage=="divorce") %>% 
  select(religion, pct)
divorce
ggplot(data=divorce, aes(x=religion, y=pct))+geom_col()


#8. 이혼~세대 및 종교
genMarriage<-welfare %>% 
  filter(!is.na(marriage)) %>% 
  count(generation, marriage) %>% 
  group_by(generation) %>% 
  mutate(pct=round(n/sum(n)*100, 1))
genMarriage

genMarriage<-genMarriage %>% 
  filter(generation!="young" & marriage=="divorce") %>% 
  select(generation, pct)
genMarriage  
ggplot(data=genMarriage, aes(x=generation, y=pct))+geom_col()

genRelMarriage<-welfare %>% 
  filter(!is.na(marriage) & generation!="young") %>% 
  count(generation, religion, marriage) %>% 
  group_by(generation, religion) %>% 
  mutate(pct=round(n/sum(n)*100, 1))

divorce<-genRelMarriage %>% 
  filter(marriage=="divorce") %>% 
  select(generation, religion, pct)
divorce
ggplot(data=divorce, aes(x=generation, y=pct, fill=religion))+
  geom_col(position="dodge")


#9. 세대~지역
class(welfare$code_region)
table(welfare$code_region)
regions<-data.frame(code_region=c(1:7),
                    region=c("서울","경기/인천","부산/경남/울산","대구/경북",
                             "대전/충남","강원/충북","광주/전남/전북/제주도"))
regions
welfare<-left_join(welfare, regions, id="code_region")
welfare %>% select(code_region, region) %>% head

regGeneration<-welfare %>% 
  count(region, generation) %>% 
  group_by(region) %>% 
  mutate(pct=round(n/sum(n)*100, 2))
head(regGeneration)

ggplot(data=regGeneration, aes(x=region, y=pct, fill=generation))+
  geom_col()+coord_flip()

#노년층 비율 오름차순 정렬
order<-regGeneration %>% 
  filter(generation=="old") %>% 
  arrange(pct)
order<-order$region
ggplot(data=regGeneration, aes(x=region, y=pct, fill=generation))+
  geom_col()+coord_flip()+scale_x_discrete(limits=order)

#세대 순으로 막대 색깔 배치
class(regGeneration$generation)
levels(regGeneration$generation)
regGeneration$generation<-factor(regGeneration$generation, level=c("old","middle","young"))
class(regGeneration$generation)
levels(regGeneration$generation)
ggplot(data=regGeneration, aes(x=region, y=pct, fill=generation))+
  geom_col()+coord_flip()+scale_x_discrete(limits=order)
