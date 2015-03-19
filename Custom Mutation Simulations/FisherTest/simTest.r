rm(list=ls())
library(ggplot2)
library(gridExtra)
library(tikzDevice)

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


theme = theme_bw() + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 


posParams = read.csv("1514087213008365_Parameters.txt", head = F, sep = "\t")
negParams = read.csv("1517043321160289_Parameters.txt", head = F, sep = "\t")
posData = read.csv("1514087213008365_StatisticOutput.txt", head = T, sep = "\t")
negData = read.csv("1517043321160289_StatisticOutput.txt", head = T, sep = "\t")
mutationScapePos = as.numeric(levels(posParams$V2[8:107]))
mutationScapeNeg = as.numeric(levels(negParams$V2[8:107]))
mutationScapePos = mutationScapePos[1:100]
mutationScapeNeg = rev(mutationScapeNeg[1:100])

x = c(1:100)
mutationScapes = data.frame(c(x,x), c(mutationScapePos, mutationScapeNeg), c(rep.int("Positive", 100), rep.int("Negative", 100))) 
names(mutationScapes) = c("x", "Probability", "Label")

deltaX = 1
velocity = deltaX*(1/(sqrt(2))) * sqrt(0.5*mutationScapeNeg*deltaX) + mutationScapeNeg*deltaX 

mutationGraph = ggplot(mutationScapes, aes(x, Probability, colour=Label)) + geom_line()

graphVelPos = ggplot(posData, aes(Time, Velocity)) + geom_line() + theme + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))
graphVelNeg = ggplot(negData, aes(Time, Velocity)) + geom_line() + theme + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))

tikz("Velocity100Pos.tex", width = 3, height = 3)
print(graphVelPos)
dev.off()
tikz("Velocity100Neg.tex", width = 3, height = 3)
print(graphVelNeg)
dev.off()



posData50 = read.csv("1509269749571109_StatisticOutput.txt", head = T, sep = "\t")
negData50 = read.csv("1509518214863183_StatisticOutput.txt", head = T, sep = "\t")
posData50Params = read.csv("1509269749571109_Parameters.txt", head = F, sep = "\t")
negData50Params = read.csv("1509518214863183_Parameters.txt", head = F, sep = "\t")


graphVelPos50 = ggplot(posData50, aes(Time, Velocity)) + geom_line() + ggtitle("Increasing Mutation Rate, 50 Mutations") + theme + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))

graphVelNeg50 = ggplot(negData50, aes(Time, Velocity)) + geom_line() + ggtitle("Decreasing Mutation Rate, 50 Mutations") + theme + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))





