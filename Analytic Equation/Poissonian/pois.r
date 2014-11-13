rm(list=ls())
library(ggplot2)
library(reshape)
library(grid)
source("poissonianFrame.r")


simData = read.csv("1303482587105654_Populations.txt", head = F, sep = "\t")
simData = simData[-7]
names(simData) = c("Time", "0", "1", "2", "3", "4")

muts = ncol(simData) - 2
fixTime = max(simData$Time)

preMelt = simData[c("0", "1", "2", "3", "4")]

simMelt = melt(preMelt)
simMelt$Time = rep.int(c(0:fixTime), 5)

names(simMelt) = c("Species", "Pop", "Time")


temp = simMelt$Pop

temp = temp/1000

simMelt$Pop = temp

analyticData = poissonianFrame(muts, fixTime, 0.01) 


grph = ggplot(simMelt, aes(Time, Pop, colour = as.factor(Species)))+geom_line()
grph = grph + geom_line(data = analyticData, aes(Time, Pop), linetype="dashed")
grph = grph + theme_bw() + theme(panel.border = element_rect(colour="black"), panel.grid.major = element_blank(), panel.grid.minor=element_blank()) + ylim(0,1) 
grph = grph + ggtitle("Simulation's vs Poissonians") 
	
