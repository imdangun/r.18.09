#1. t-test
library(dplyr)
mpg<-ggplot2::mpg

# cty~class
mpg1<-mpg %>% select(class, cty) %>% filter(class %in% c("compact", "suv"))
table(mpg1$class)
t.test(data=mpg1, cty~class, var.equal=T)

# cty~fl
mpg2<-mpg %>% select(fl, cty) %>% filter(fl %in% c("r","p"))
table(mpg2$fl)
t.test(data=mpg2, cty~fl, var.equal=T)


#2. Correlation Analysis
economics<-ggplot2::economics
cor.test(economics$unemploy, economics$pce)

# correlation matrix
install.packages("corrplot")
library(corrplot)

head(mtcars)
car<-cor(mtcars)
round(car, 2)
corrplot(car)
corrplot(car, method="number")

col<-colorRampPalette(c("#BB4444","EEE9988","#FFFFFF","#77AADD","#4477AA"))
corrplot(car,
         method="color",
         type="lower",
         order="hclust",
         addCoef.col="black",
         tl.col="red",
         tl.srt=45,
         diag=F)