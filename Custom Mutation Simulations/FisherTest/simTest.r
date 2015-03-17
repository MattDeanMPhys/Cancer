rm(list=ls())
library(ggplot2)
library(gridExtra)

files = list.files()

statFiles = grep("Statistic", files, value = TRUE)

i = 1 

while(i <= length(statFiles)){

	data = read.csv(statFiles[i], head = T, sep = "\t")

	graphD = ggplot(data, aes(Time, Displacement)) + geom_line()
	graphVel = ggplot(data, aes(Time, Velocity)) + geom_line()
	graphVar =  ggplot(data, aes(Time, Variance)) + geom_line()
	
	quartz()
	grid.arrange(graphD, graphVel, graphVar, ncol=2)

	i = i + 1
}
