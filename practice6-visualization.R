# Date- 10/02/2021
library(ggplot2)
mtcars
counts<- table(mtcars$gear) #select specific column which to represent
barplot(counts,  horiz=TRUE) #horiz can tilt the plot horizontally
barplot(counts,
        main = "simple barplot",    #it will give the name to the plot
        ylab = "frequency",       #it will indicate Y-axis
        xlab = "improvement",     #it will indicate X-axis
        col =c("red","yellow","green")) #it is used to give different color to the bars

#***********************************Pie chart**********************************
install.packages("ggplot2") # package need to install for visualization
sectors<- c(25,24,31,20)
slices<- round(sectors/sum(sectors)* 100) #this formula used to convert a sector values into percentage
lbls<-paste(c("ashu","adi","rohan","suyash"), #paste is use to mix all the instructions on chart
            " ",slices,"%",
            sep = "")
pie(sectors,main= "simple piechart",labels = lbls,
    col = rainbow(4),edges = 200)

library("plotrix")#For 3D plotting we need to install
install.packages("plotrix")
pie3D(sectors,main= "simple piechart",labels = lbls,
    col = rainbow(4),edges = 200,explode =0.0 )# explode is depth of the circle


#*****************************KERNAL DENSITY CHART*****************************
plot(density(mtcars$mpg))
x <- density(iris$Sepal.Width)
plot(x,main = "density plot iris vs sepal width") #edited some indication labels
polygon(x, col = "skyblue",border = "red") #ploygon is use to edit the color combination in chart

#*****************************LINE CHART***************************************
weight_gain<-c(1,1.5,2.5,3,4,5.5)
months<- c(0,1,2,3,4,5)
plot(weight_gain,months,type= "b",col = "brown")

#*****************************BOX PLOT***************************************
summary(airquality)
boxplot(airquality$Ozone,col = "violet",horizontal = TRUE)

#*****************************word cloud***************************************
install.packages("wordcloud")
library("wordcloud")
iris<- read.csv("TEXT.csv",header = TRUE)
head(iris)
wordcloud(words =iris$Species,freq = iris$freq,min.freq = 2,max.words = 100,random.order = FALSE)


#***********************************GGPLOT2*************************************
install.packages("ggplot2")
library("ggplot2")
#to save graphic plot use foloowing code
jpeg("myplot.jpg")
counts<- c(mtcars$gear)
barplot(counts)
dev.off()