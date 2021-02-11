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