#1. plotly package
install.packages("plotly")
library(plotly)
library(ggplot2)

p<-ggplot(data=mpg, aes(x=displ, y=hwy, col=drv))+geom_point()
ggplotly(p)
p<-ggplot(data=diamonds, aes(x=cut, fill=clarity))+geom_bar(position="dodge")
ggplotly(p)


#2. dygraphs package
install.packages("dygraphs")
library(dygraphs)
economics<-ggplot2::economics
head(economics)

library(xts)
eco<-xts(economics$unemploy, order.by=economics$date)
head(eco)
dygraph(eco)
dygraph(eco) %>% dyRangeSelector()

eco1<-xts(economics$psavert, order.by=economics$date)
eco2<-xts(economics$unemploy/1000, order.by=economics$date)
eco<-cbind(eco1, eco2)
head(eco)
colnames(eco)<-c("psavert", "unemploy")
head(eco)
dygraph(eco) %>% dyRangeSelector()
