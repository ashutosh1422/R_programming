library("plyr")
mtcars
new_mtcars<- transform(mtcars,performance= ifelse(cyl==4,"lowpower",ifelse(cyl==8,"highpower","midiumpower")))
new_mtcars
table(new_mtcars$performance,new_mtcars$mpg)

vec<- c(1,"hallo",TRUE)
vec
