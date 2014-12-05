rm(list=ls())
library(ggplot2)
library(reshape)
library(grid)
library(tikzDevice)
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

themeBase = theme_bw(base_size=10) + theme(  panel.border = element_rect(colour = "black"), 
		    panel.grid.major = element_blank(), 
		    panel.grid.minor = element_blank(),
		    axis.ticks.length = unit(0.15, "cm"),
		    axis.ticks.margin = unit(0.15, "cm")

			)

grph = ggplot(simMelt, aes(Time, Pop, group = as.factor(Species))) + geom_line(colour = "gray53")  + themeBase

grph = grph + theme(legend.position = c(0.90,0.5)) 

grph = grph + geom_line(data = analyticData, aes(Time, Pop, group = as.factor(Species)), colour = "black")
grph = grph + scale_y_continuous(name = "Population Fraction", expand=c(0,0)) + scale_x_continuous(expand=c(0,0))
grph = grph + ggtitle("Simulation and Poissonian")
	
tikz(file = "PoissonianGraph.tex", width = 3, height = 3)
print(grph)
dev.off()


