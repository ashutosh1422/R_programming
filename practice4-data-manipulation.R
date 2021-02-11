#date- 9/02/2021
#*********************************APPLY_FUNCTION********************************

x <- matrix(c(1,2,3,4),2,2,byrow = TRUE)
x
apply(x,1,sum) # 1 is margin function sum will apply by row
apply(x,2,sum) # 2 is margin function sum will apply by column

m <- matrix(c(1,2,3,4),2,2)
m
apply(m,1,mean)
apply(m,2,mean)

#*********************************SAPPLY_FUNCTION*******************************
list<- list(a=c(1,2),b=c(3,11),c=c(5,6))
sapply(list,sum)
sapply(list,range)

#*********************************dplyr_Package*******************************
library(dplyr)
help("iris")
iris
select(iris,matches(".t."))
select(iris,starts_with("sepal.length"))
select(iris,ends_with("petal.width"))

mtcars
arrange(mtcars,cyl,disp)
arrange(mtcars,desc(qsec))

filter(mtcars,cyl==8) #it will only write the columns which have 8 no of cyl
filter(mtcars,cyl< 6 & vs==1)#it will only write the columns which have 4 cyl AND vs==1

mutate(mtcars,my_new_cyl= cyl/10)

mtcars
summarise(mtcars,IQR(mpg))#IQR is Inter quartile range
summarise(mtcars,max(disp))
summarise(mtcars,min(disp))
