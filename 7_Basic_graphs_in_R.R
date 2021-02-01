A <- c(3, 2, 5, 6, 4, 8, 1, 2, 3, 2, 4)
boxplot(A)
#Look at the built-in dataset mtcars.

print(mtcars)

#Now create a box plot for vehicle weight for each type of car.
boxplot(wt~cyl, data=mtcars, main=toupper("Vehicle Weight"), 
        font.main=3, cex.main=1.2, xlab="Number of Cylinders", 
        ylab="Weight", font.lab=3, col="darkgreen")
boxplot(mpg~cyl, data=mtcars, main= toupper("Fuel Consumption"), 
        font.main=3, cex.main=1.2, col=c("red","blue", "yellow"), 
        xlab="Number of Cylinders", ylab="Miles per Gallon", 
        font.lab=3, notch=TRUE, range = 0)


#####################################################################

library(MASS)
painters # import the dataset

#The last School column contains the information of school classification of the painters. 
#The schools are named as A, B, ..., etc, and the School variable is qualitative.


help(painters)
painters$School

# Frequency Distribution of Qualitative Data

# The frequency distribution of a data variable is a summary of the data occurrence 
#in a collection of non-overlapping categories.
# 
# Example
# In the data set painters, the frequency distribution of the School variable 
#is a summary of the number of painters in each school.
# 
# Problem
# Find the frequency distribution of the painter schools in the data set painters.

# Solution
# We apply the table function to compute the frequency distribution of the School variable.
# 
# 
library(MASS)                 # load the MASS package 
school = painters$School      # the painter schools 
school.freq = table(school)   # apply the table function

# Enhanced Solution
# We apply the cbind function to print the result in column format.


#Relative Frequency Distribution of Qualitative Data

# The relative frequency distribution of a data variable is a summary 
# of the frequency proportion in a collection of non-overlapping categories.
# 
# The relationship of frequency and relative frequency is:
# 
# Relative F requency = Frequency/Sample Size


# Example
# In the data set painters, the relative frequency distribution of the School 
# variable is a summary of the proportion of painters in each school.
# 
# Problem
# Find the relative frequency distribution of the painter schools in the data set painters.
# 
# Solution
# We first apply the table function to compute the frequency distribution of 
# the School variable.

library(MASS)                 # load the MASS package 
school = painters$School      # the painter schools 
school.freq = table(school)   # apply the table function

# Then we find the sample size of painters with the nrow function, 
# and divide the frequency distribution with it. Therefore the relative frequency distribution is:

school.relfreq = school.freq / nrow(painters)

# Answer
# The relative frequency distribution of the schools is:

school.relfreq 

# school 
# A        B        C        D        E        F 
# 0.185185 0.111111 0.111111 0.185185 0.129630 0.074074 
# G        H 
# 0.129630 0.074074
# 
# Enhanced Solution
# We can print with fewer digits and make it more readable by setting the digits option.

old = options(digits=2) 

school.relfreq 
# school 
# A    B    C    D    E    F    G    H 
# 0.19 0.11 0.11 0.19 0.13 0.07 0.13 0.07

old = options(digits=1) 
cbind(school.relfreq) 
school.relfreq1 = cbind(school.relfreq) 
school.relfreq1

options(old)    # restore the old option


# Bar Graph
# 
# A bar graph of a qualitative data sample consists of vertical parallel bars 
# that shows the frequency distribution graphically.
# 
# Example
# In the data set painters, the bar graph of the School variable is 
# a collection of vertical bars showing the number of painters in each school.
# 
# Problem
# Find the bar graph of the painter schools in the data set painters.
# 
# Solution
# We first apply the table function to compute the frequency distribution 
# of the School variable.

library(MASS)                 # load the MASS package 
school = painters$School      # the painter schools 
school.freq = table(school)   # apply the table function
barplot(school.freq)         # apply the barplot function

# Enhanced Solution
# To colorize the bar graph, we select a color palette and set it 
# in the col argument of barplot.


colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(school.freq,col=colors)      # apply the barplot function # set the color palette


pie(school.freq)              # apply the pie function

colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(school.freq,col=colors)            # apply the pie function  # set the color palette


# Quantitative data, also known as continuous data, consists of numeric 
# ata that support arithmetic operations. This is in contrast
# with qualitative data, whose values belong to pre-defined classes
# with no arithmetic operation allowed. 
