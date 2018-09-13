# jdk를 설치한다.
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("stringr")
install.packages("wordcloud")

library(KoNLP)
library(dplyr)
library(stringr)
library(wordcloud)
useNIADic()

#1. 노래 가사
txt<-readLines("hiphop.txt")
head(txt)
txt<-str_replace_all(txt, "\\W", " ") #W는 대문자이다.
head(txt)
nouns<-extractNoun(txt); #extractNoun(): list로 return
wordCnt<-table(unlist(nouns)) #unlist(): vector로 return, #table(): table로 return.
words<-as.data.frame(wordCnt, stringsAsFactors=F)
head(words)
words<-rename(words, word=Var1, freq=Freq)
words<-filter(words, nchar(word)>=2)

top20<-words %>% arrange(desc(freq)) %>% head(20)
top20

pal<-brewer.pal(8,"Dark2")
pal
wordcloud(words=words$word,
          freq=words$freq,
          min.freq=2,
          max.words=200,
          random.order=F, #고빈도 단어는 중앙에 배치.
          rot.per=.1,     #회전 단어 비율.
          scale=c(4, 0.3),#단어 크기 범위.
          colors=pal)


#2. 국정원 트윗
twitter<-read.csv("twitter.csv", header=T, stringsAsFactors=F, fileEncoding="utf-8")
twitter<-rename(twitter, no="번호", id="계정이름", date="작성일", tw="내용")
head(twitter)
twitter$tw<-str_replace_all(twitter$tw, "\\W", " ")
nouns<-extractNoun(twitter$tw)
wordCnt<-table(unlist(nouns))
words<-as.data.frame(wordCnt, stringsAsFactors=F)
words<-rename(words, word=Var1, freq=Freq)
words<-filter(words, nchar(word)>=2)
top20<-words %>% arrange(desc(freq)) %>% head(20)
top20

order<-arrange(top20, freq)$word
ggplot(data=top20, aes(x=word, y=freq))+
  ylim(0,2500)+
  geom_col()+
  coord_flip()+
  scale_x_discrete(limit=order)+
  geom_text(aes(label=freq), hjust=-0.3)

pal<-brewer.pal(8,"Dark2")
wordcloud(words=words$word,
          freq=words$freq,
          min.freq=10,
          max.words=200,
          random.order=F,
          rot.per=.1,
          scale=c(6, 0.2),
          colors=pal)

pal<-brewer.pal(9,"Blues")[5:9]
wordcloud(words=words$word,
          freq=words$freq,
          min.freq=10,
          max.words=200,
          random.order=F,
          rot.per=.1,
          scale=c(6,0.2),
          colors=pal)
