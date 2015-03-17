rm(list=ls())
library(ggplot2)
library(gridExtra)

files = list.files()

statFiles = grep("Statistic", files, value = TRUE)

#i = 4 
#
#while(i <= length(statFiles)){
#
#	data = read.csv(statFiles[i], head = T, sep = "\t")
#
#	graphD = ggplot(data, aes(Time, Displacement)) + geom_line()
#	graphVel = ggplot(data, aes(Time, Velocity)) + geom_line()
#	graphVar =  ggplot(data, aes(Time, Variance)) + geom_line()
#	
#	quartz()
#	grid.arrange(graphD, graphVel, graphVar, ncol=2)
#
#	i = i + 1
#}

posData = read.csv("1514087213008365_StatisticOutput.txt", head = T, sep = "\t")
negData = read.csv("1517043321160289_StatisticOutput.txt", head = T, sep = "\t")

graphVelPos = ggplot(posData, aes(Time, Velocity)) + geom_line() + ggtitle("Increasing Mutation Rate, 100 Mutations")
graphVelNeg = ggplot(negData, aes(Time, Velocity)) + geom_line() + ggtitle("Decreasing Mutation Rate, 100 Mutations")

posData50 = read.csv("1509269749571109_StatisticOutput.txt", head = T, sep = "\t")
negData50 = read.csv("1509518214863183_StatisticOutput.txt", head = T, sep = "\t")

graphVelPos50 = ggplot(posData, aes(Time, Velocity)) + geom_line() + ggtitle("Increasing Mutation Rate, 50 Mutations")
graphVelNeg50 = ggplot(negData, aes(Time, Velocity)) + geom_line() + ggtitle("Decreasing Mutation Rate, 50 Mutations")




