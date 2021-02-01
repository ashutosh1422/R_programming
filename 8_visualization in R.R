# Ggplot2 library
library(ggplot2)
diamonds
#diamonds
ggplot(diamonds)  # if only the dataset is known.
ggplot(diamonds, aes(x=carat))  
# if only X-axis is known. The Y-axis can be specified in respective geoms.
ggplot(diamonds, aes(x=carat, y=price))  
# if both X and Y axes are fixed for all layers.
ggplot(diamonds, aes(x=carat, color=cut))  
# Each category of the 'cut' variable will now have a distinct  color, once a geom is added.
ggplot(diamonds, aes(x=carat), color="steelblue")

# The Layers
# The layers in ggplot2 are also called 'geoms'. Once the base setup is done,
# you can append the geoms one on top of the other. The documentation provides a
# compehensive list of all available geoms.
# 

# Adding scatterplot geom (layer1) and smoothing geom (layer2)

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() 


# Notice the X and Y axis and how the color of the points vary based on the value of 
# cut variable. The legend was automatically added. I would like to propose a change 
# though. Instead of having multiple smoothing lines for each level of cut, IF you want to 
# integrate them all under one line. How to do that? Removing the color aesthetic from
# geom_smooth() layer would accomplish that.


#Problem Can you make the shape of the points vary with color feature?

# Answer to the challenge.
ggplot(diamonds, aes(x=carat, y=price, color=cut, shape=color)) + geom_point()


# The Labels
# Now that you have drawn the main parts of the graph. You might want to add the plot's
# main title and perhaps change the X and Y axis titles. This can be accomplished using 
# the labs layer, meant for specifying the labels. However, manipulating the size, color 
# of the labels is the job of the 'Theme'.


gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + labs(title="Scatterplot", x="Caratt", y="Pricee")  # add axis lables and plot title.
print(gg)

# The plot's main title is added and the X and Y axis labels capitalized.
# 
# Note: If you are showing a ggplot inside a function, you need to explicitly 
# save it and then print using the print(gg), like we just did above.


# Working on the theme

# Almost everything is set, except that we want to increase the size of the labels and 
# change the legend title. Adjusting the size of labels can be done using the theme() 
# function by setting the plot.title, axis.text.x and axis.text.y. They need to be specified 
# inside the element_text(). If you want to remove any of them, set it to element_blank() 
# and it will vanish entirely.


# Adjusting the legend title is a bit tricky. If your legend is that of a color attribute 
# and it varies based in a factor, you need to set the name using scale_color_discrete(),
# where the color part belongs to the color attribute and the discrete because the legend 
# is based on a factor variable.


gg1 <- gg + theme(plot.title=element_text(size=30, face="bold"), 
                  axis.text.x=element_text(size=15), 
                  axis.text.y=element_text(size=15),
                  axis.title.x=element_text(size=25),
                  axis.title.y=element_text(size=25)) + 
  scale_color_discrete(name="Cut of diamonds")  # add title and axis text, change legend title.

print(gg1)  # print the plot


# Important:

# If the legend shows a shape attribute based on a factor variable, you need to change it
# using scale_shape_discrete(name="legend title"). Had it been a continuous variable, use 
# scale_shape_continuous(name="legend title") instead.

#So now, Can you guess the function to use if your legend is based on a fill attribute
#on a continuous variable?

#The answer is scale_fill_continuous(name="legend title").
# Please use the feature and show it in the markdown

# The Facets

gg1 + facet_wrap( ~ cut, ncol=3)  # columns defined by 'cut'

# facet_wrap(formula) takes in a formula as the argument. 
# The item on the RHS corresponds to the column. The item on the LHS defines the rows.

gg1 + facet_wrap(color ~ cut)  # row: color, column: cut

# In facet_wrap, the scales of the X and Y axis are fixed to accomodate all points by default. 
# This would make comparison of attributes meaningful because they would be in the same scale. 
# However, it is possible to make the scales roam free making the charts look more evenly 
# distributed by setting the argument scales=free.

gg1 + facet_wrap(color ~ cut, scales="free")  # row: color, column: cut

#For comparison purposes, you can put all the plots in a grid as well using facet_grid(formula).

gg1 + facet_grid(color ~ cut)   # In a grid

#Commonly Used Features

#Make a time series plot (using ggfortify)

# The ggfortify package makes it very easy to plot time series directly from a 
# time series object, without having to convert it to a dataframe. The example below 
# plots the AirPassengers timeseries in one step

AirPassengers
library(ggfortify)
autoplot(AirPassengers) + labs(title="AirPassengers")
# where AirPassengers is a 'ts' object


# Bar charts
# 
# By default, ggplot makes a 'counts' barchart, meaning, it counts the frequency 
# of items specified by the x aesthetic and plots it. In this format, you don't need
# to specify the Y aesthetic. However, if you would like the make a bar chart of the 
# absolute number, given by Y aesthetic, you need to set stat="identity" inside the geom_bar.

plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar() + labs(title="Frequency bar chart")  # Y axis derived from counts of X item
print(plot1)

df <- data.frame(var=c("a", "b", "c"), nums=c(1:3))
plot2 <- ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity")  # Y axis is explicit. 'stat=identity'
print(plot2)
# 
# Custom layout
# 
# The gridExtra package provides the facility to arrage multiple ggplots in a single grid.

library(gridExtra)
grid.arrange(plot1, plot2, ncol=2)


# Flipping coordinates
df <- data.frame(var=c("a", "b", "c"), nums=c(1:3))
ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity") + coord_flip() + labs(title="Coordinates are flipped")

# Adjust X and Y axis limits
# here are 3 ways to change the X and Y axis limits.
#
# Using coord_cartesian(xlim=c(x1,x2))
# Using xlim(c(x1,x2))
# Using scale_x_continuous(limits=c(x1,x2))


ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + coord_cartesian(ylim=c(0, 10000)) + labs(title="Coord_cartesian zoomed in!")

# Warning: Items 2 and 3 will delete the datapoints that lie outisde the limit from 
# the data itself. So, if you add any smoothing line line and such, the outcome will
# be distorted. Item 1 (coord_cartesian) does not delete any datapoint, but instead zooms
# in to a specific region of the chart.

ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + ylim(c(0, 10000)) + labs(title="Datapoints deleted: Note the change in smoothing lines!")
#> Warning messages:
#> 1: Removed 5222 rows containing non-finite values
#> (stat_smooth). 
#> 2: Removed 5222 rows containing missing values
#> (geom_point).


#The ggthemes package provides additional ggplot themes that imitates famous 
#magazines and softwares. Here is an example of how to change the theme
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() +theme_bw() + labs(title="bw Theme")

#Legend - Deleting and Changing Position

# By setting theme(legend.position="none"), you can remove the legend. 
# By setting it to 'top', i.e. theme(legend.position="top"), you can move the
# legend around the plot. By setting legend.postion to a co-ordinate inside the plot 
# you can place the legend inside the plot itself. The legend.justification denotes the
# anchor point of the legend, i.e. the point that will be placed on the co-ordinates given
# by legend.position.


p1 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + theme(legend.position="none") + labs(title="legend.position='none'")  # remove legend
p2 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + theme(legend.position="top") + labs(title="legend.position='top'")  # legend at top
p3 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() + labs(title="legend.position='coords inside plot'") + theme(legend.justification=c(1,0), legend.position=c(1,0))  # legend inside the plot.
grid.arrange(p1, p2, p3, ncol=3)  # arrange




gg <- ggplot(df, aes(x=xcol, y=ycol)) 

#df must be a dataframe that contains all information to make the ggplot. 
#Plot will show up only after adding the geom layers

library(ggplot2)
gg <- ggplot(diamonds, aes(x=carat, y=price)) 
gg + geom_point()

gg + geom_point(size=1, shape=1, color="steelblue", stroke=2)  # 'stroke' controls the thickness of point boundary


# Adding Grid lines
ggplot(mtcars, aes(x=cyl)) + geom_bar(fill='darkgoldenrod2') +
  theme(panel.background = element_rect(fill = 'steelblue'),
        panel.grid.major = element_line(colour = "firebrick", size=3),
        panel.grid.minor = element_line(colour = "blue", size=1))


# Plot margin and background

ggplot(mtcars, aes(x=cyl)) + geom_bar(fill="firebrick") + theme(plot.background=element_rect(fill="steelblue"), plot.margin = unit(c(2, 4, 1, 3), "cm")) # top, right, bottom, left

#Static - point size, shape, color and boundary thickness

mpg
str(mpg)

qplot(displ, hwy, data = mpg)

# Lets make it more powerful
# we will add some legends and colors to it

qplot(displ, hwy, data = mpg, color = drv)

# Lets add some stats 
# we will add a loess lib=ne to the diagram
# we want to see the smoothness to diagram

qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

# 95 confidence interval is being displayed in the grey line

#qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"))
# we can plot a histogram by providing one variable (hwy milaege for all cars) 

qplot (hwy, data = mpg, fill = drv)

# Facets (creating subsets of the data nd color them)

qplot(displ, hwy, data = mpg, facets = .~drv)




# Use the mtcars dataset.
head(mtcars)

# Basic barplot:
ggplot(mtcars, aes(x=as.factor(cyl) )) + geom_bar()

# Create data
data=data.frame(name=c("A","B","C","D","E") ,value=c(3,12,5,18,45))

# Barplot
ggplot(data, aes(x=name, y=value)) + geom_bar(stat = "identity")

# 1: uniform color. Color is for the border, fill is for the inside
ggplot(mtcars, aes(x=as.factor(cyl) )) +
  geom_bar(color="blue", fill=rgb(0.1,0.4,0.5,0.8) )

# 2: Using Hue
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + geom_bar( ) +
  scale_fill_hue(c = 40)

# 3: Using RColorBrewer
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + geom_bar( ) +
  scale_fill_brewer(palette = "Set1")

# 4: Using greyscale:
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + geom_bar( ) +
  scale_fill_grey(start = 0.25, end = 0.75)

# 5: Set manualy
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + geom_bar( ) +
  scale_fill_manual(values = c("red", "green", "blue") )

# The 3 last examples show you how to: 1/ Remove legend and add axis names 2/ Make an horizontal barplot with ggplot2 3/ Custom the width of bars

# 1/ remove legend and add axis names
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
  geom_bar( ) + 
  theme(legend.position = "none") +
  labs(x = "My class", y = "Value")

# 2/ horizontal barplot
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
  geom_bar() + 
  coord_flip()

# 3/ Custom bar width
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl)  )) +
  geom_bar(width=0.4) +

# The 3 last examples show you how to: 1/ Remove legend and add axis names 
# 2/ Make an horizontal barplot with ggplot2 3/ Custom the width of bars
  
# 1/ remove legend and add axis names
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
  geom_bar( ) + 
  theme(legend.position = "none") +
  labs(x = "My class", y = "Value")

# 2/ horizontal barplot
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +
  geom_bar() + 
  coord_flip()

# 3/ Custom bar width
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl)  )) +
  geom_bar(width=0.4)
  
# BARPLOT WITH VARIABLE WIDTH

# make data
data=data.frame(group=c("A ","B ","C ","D ") , value=c(33,62,56,67) , 
                number_of_obs=c(100,500,459,342))

# Calculate the future positions on the x axis of each bar (left border, central position, right border)
data$right=cumsum(data$number_of_obs) + 30*c(0:(nrow(data)-1))
data$left=data$right - data$number_of_obs 

# Plot
ggplot(data, aes(ymin = 0)) + 
  geom_rect(aes(xmin = left, xmax = right, ymax = value, colour = group, fill = group)) +
  xlab("number of obs") + ylab("value")

# CIRCULAR BARPLOT

# make data
data=data.frame(group=c("A ","B ","C ","D ") , value=c(33,62,56,67) )

# Usual bar plot :
ggplot(data, aes(x = group, y = value ,fill = group )) + 
  geom_bar(width = 0.85, stat="identity")

# GROUPED BARPLOT WITH GGPLOT2

# create a dataset
specie=c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition=rep(c("normal" , "stress" , "Nitrogen") , 4)
value=abs(rnorm(12 , 0 , 15))
data=data.frame(specie,condition,value)

# Grouped
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="dodge", stat="identity")

# Stacked
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar( stat="identity")

# Stacked Percent
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar( stat="identity", position="fill")


# color with RcolorBrewer
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar( stat="identity", position="fill") +
  scale_fill_brewer(palette = "Set1")

# Faceting
ggplot(data, aes(y=value, x=specie, color=specie, fill=specie)) + 
  geom_bar( stat="identity") +
  facet_wrap(~condition)

# BASIC GGPLOT2 HISTOGRAM

# dataset:
data=data.frame(value=rnorm(10000))

# Basic histogram
ggplot(data, aes(x=value)) + geom_histogram()

# Custom Binning. I can just give the size of the bin
ggplot(data, aes(x=value)) + geom_histogram(binwidth = 0.05)

# Uniform color
ggplot(data, aes(x=value)) + 
  geom_histogram(binwidth = 0.2, color="white", fill=rgb(0.2,0.7,0.1,0.4)) 

# Proportional color
ggplot(data, aes(x=value)) + 
  geom_histogram(binwidth = 0.2, aes(fill = ..count..) )


# BASIC SCATTERPLOT WITH GGPLOT2

# The iris dataset is proposed by R
head(iris)

# basic scatterplot
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point()

# CUSTOM YOUR SCATTERPLOT | GGPLOT2

# The iris dataset
head(iris)

# use options!
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point(
    color="red",
    fill="blue",
    shape=21,
    alpha=0.5,
    size=6,
    stroke = 2
  )

# MAP A VARIABLE TO GGPLOT2 SCATTERPLOT

# Color and shape depend on factor (categorical variable)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species, shape=Species)) + 
  geom_point(size=6, alpha=0.6)

# Color and shape depend on factor (categorical variable)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Petal.Length, size=Petal.Length)) + 
  geom_point(alpha=0.6)

# SCATTER PLOT WITH GGPLOT2

# Data
data=data.frame(cond = rep(c("condition_1", "condition_2"), each=10), my_x = 1:100 + rnorm(100,sd=9), my_y = 1:100 + rnorm(100,sd=16) )

# Basic scatter plot. Shape=1 is to have circles
ggplot(data, aes(x=my_x, y=my_y)) + geom_point(shape=1)

# Add a linear trend :
ggplot(data, aes(x=my_x, y=my_y)) + geom_point(shape=1) + 
  geom_smooth(method=lm, color="red", se=FALSE) # Add linear regression line 

# Add a linear trend :
ggplot(data, aes(x=my_x, y=my_y)) + geom_point(shape=1) + 
  geom_smooth(method=lm , color="red", se=TRUE) # Add linear regression line 

# MULTIPLE GGPLOT2 GRAPHICS IN ONE PAGE

# Libraries
library(gridExtra)

# Load the diamonds dataset
data(diamonds)

# Create a histogram, assign to "plot1"
plot1 <- qplot(price,data=diamonds,binwidth=1000)

# Create a scatterplot (plot2)
plot2 <- qplot(carat,price,data=diamonds,colour = cut)

# Arrange and display the plots into a 2x1 grid
grid.arrange(plot1,plot2,ncol=1)

##########

# Make 3 simple graphics:
g1=ggplot(mtcars, aes(x=qsec)) + geom_density(fill="slateblue")
g2=ggplot(mtcars, aes(x=drat, y=qsec, color=cyl)) + geom_point(size=5) + theme(legend.position="none")
g3=ggplot(mtcars, aes(x=factor(cyl), y=qsec, fill=cyl)) + geom_boxplot() + theme(legend.position="none")
g4=ggplot(mtcars , aes(x=factor(cyl), fill=factor(cyl))) + geom_bar()

# Show the 4 plots on the same page
grid.arrange(g1, g2, g3, g4, ncol=2, nrow =2)

# Plots
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 2)
grid.arrange(g1, g2, g3, nrow = 3)
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 1)
grid.arrange(g2, arrangeGrob(g3, g4, nrow=2), nrow = 1)

#############

# Make 3 simple graphics:
g1=ggplot(mtcars, aes(x=qsec)) + geom_density(fill="slateblue")
g2=ggplot(mtcars, aes(x=drat, y=qsec, color=cyl)) + geom_point(size=5) + theme(legend.position="none")
g3=ggplot(mtcars, aes(x=factor(cyl), y=qsec, fill=cyl)) + geom_boxplot() + theme(legend.position="none")
g4=ggplot(mtcars , aes(x=factor(cyl), fill=factor(cyl))) + geom_bar()

# Show the 4 plots on the same page
grid.arrange(g1, g2, g3, g4, ncol=2, nrow =2)

# Plots
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 2)
grid.arrange(g1, g2, g3, nrow = 3)
grid.arrange(g2, arrangeGrob(g3, g4, ncol=2), nrow = 1)
grid.arrange(g2, arrangeGrob(g3, g4, nrow=2), nrow = 1)

##########

# PLOTTING TIME SERIES WITH GGPLOT2

# library
#install.packages("tidyverse")
library(tidyverse)

# Build a Time serie data set
day=as.Date("2017-06-14") - 0:364
value=runif(365) + seq(-140, 224)^2 / 10000
data=data.frame(day, value)

as.Date(data$your_column, "yourformat")
as.Date("1jan1960", "%d%b%Y")
as.Date("02/27/92", "%m/%d/%y")

p=ggplot(data, aes(x=day, y=value)) +
  geom_line() + 
  xlab("")
p

p+scale_x_date(date_labels = "%b")
p+scale_x_date(date_labels = "%Y %b %d")
p+scale_x_date(date_labels = "%W")
p+scale_x_date(date_labels = "%m-%Y")

p + scale_x_date(date_breaks = "1 week", date_labels = "%W")
p + scale_x_date(date_breaks = "2 week", date_labels = "%b %d")
p + scale_x_date(date_minor_breaks = "2 day")

p + theme(axis.text.x=element_text(angle=60, hjust=1))
p + scale_x_date(limit=c(as.Date("2017-01-01"),as.Date("2017-02-11")))

# DISTRIBUTION PLOT USING GGPLOT2

# For the weatherAUS dataset.
library(rattle)

# To generate a density plot.
library(ggplot2)  
cities <- c("Canberra", "Darwin", "Melbourne", "Sydney")
ds <- subset(weatherAUS, Location %in% cities & ! is.na(Temp3pm))
p  <- ggplot(ds, aes(Temp3pm, colour=Location, fill=Location))
p  <- p + geom_density(alpha=0.55)
p

# STACKED DENSITY GRAPH

# ggplot2 library
library(ggplot2)

# Let's use the diamonds dataset
data(diamonds)
head(diamonds)

# plot 1: Density of price for each type of cut of the diamond:
ggplot(data=diamonds,aes(x=price, group=cut, fill=cut)) + 
  geom_density(adjust=1.5)

# plot 2: Density plot with transparency (using the alpha argument):
ggplot(data=diamonds,aes(x=price, group=cut, fill=cut)) + 
  geom_density(adjust=1.5 , alpha=0.2)

# plot 3: Stacked density plot:
ggplot(data=diamonds,aes(x=price, group=cut, fill=cut)) + 
  geom_density(adjust=1.5, position="fill")

# plot 4
ggplot(diamonds, aes(x=depth, y=..density..)) + 
  geom_density(aes(fill=cut), position="stack") +
  xlim(50,75) + 
  theme(legend.position="none")

# GGPLOT2 BOXPLOT FROM CONTINUOUS VARIABLE

# plot
ggplot(diamonds, aes(x=carat, y=price)) +
  geom_boxplot(fill="skyblue", aes(group = cut_width(carat, 0.5)))

# CONTROL GGPLOT2 BOXPLOT COLORS

# The mtcars dataset is proposed in R
head(mpg)

# Set a unique color with fill, colour, and alpha
ggplot(mpg, aes(x=class, y=hwy)) + 
  geom_boxplot(color="red", fill="orange", alpha=0.2)

# Set a different color for each group
ggplot(mpg, aes(x=class, y=hwy, fill=class)) + 
  geom_boxplot(alpha=0.3) +
  theme(legend.position="none")

# GGPLOT2 BOXPLOT WITH AVERAGE VALUE

# create data
names=c(rep("A", 20) , rep("B", 8) , rep("C", 30), rep("D", 80))
value=c( sample(2:5, 20 , replace=T) , sample(4:10, 8 , replace=T), sample(1:7, 30 , replace=T), sample(3:8, 80 , replace=T) )
data=data.frame(names,value)

# plot
ggplot(data, aes(x=names, y=value, fill=names)) +
  geom_boxplot(alpha=0.4) +
  stat_summary(fun.y=mean, geom="point", shape=20, size=10, color="red", fill="red") +
  theme(legend.position="none") +
  scale_fill_brewer(palette="Set3")

# Circular one
ggplot(data, aes(x = group, y = value ,fill = group)) + 
  geom_bar(width = 0.85, stat="identity") +
  
  # To use a polar plot and not a basic barplot
  coord_polar(theta = "y") +
  
  #Remove useless labels of axis
  xlab("") + ylab("") +
  
  #Increase ylim to avoid having a complete circle
  ylim(c(0,75)) + 
  
  #Add group labels close to the bars :
  geom_text(data = data, hjust = 1, size = 3, aes(x = group, y = 0, label = group)) +
  
  #Remove useless legend, y axis ticks and y axis text
  theme(legend.position = "none" , axis.text.y = element_blank() , axis.ticks = element_blank())