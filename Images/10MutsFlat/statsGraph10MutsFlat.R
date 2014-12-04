rm(list=ls())
library(ggplot2)
library(grid)
library(tikzDevice)


data = read.csv("160641483882148_StatisticOutput.txt", sep = "\t")


graphDisp = ggplot(data, aes(Time, Displacement)) + geom_line()
graphDisp = graphDisp + theme_bw(base_size=10) + theme(  panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
graphDisp = graphDisp + theme(axis.ticks.length = unit(-0.25, "cm"),  axis.ticks.margin = unit(0.5, "cm"))	
graphDisp = graphDisp + theme(axis.title.y = element_text(vjust = 1.0))
graphDisp = graphDisp + scale_x_continuous("Time", expand = c(0,0))
graphDisp = graphDisp + scale_y_continuous(limits = c(0,9), "Displacement", expand = c(0,0.0))
graphDisp = graphDisp + ggtitle("Centre of Mass of cloud" )	

tikz(file = "10MutsFlatDisp.tex", width = 3, height = 3 )
print(graphDisp)
dev.off()

graphVel = ggplot(data, aes(Time, Velocity)) + geom_line() + geom_smooth(se=F)
graphVel = graphVel + theme_bw(base_size=10) + theme(  panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
graphVel = graphVel + theme(axis.ticks.length = unit(-0.25, "cm"),  axis.ticks.margin = unit(0.5, "cm"))	
graphVel = graphVel + theme(axis.title.y = element_text(vjust = 1.0))
graphVel = graphVel + scale_x_continuous("Time", expand = c(0,0))
graphVel = graphVel + scale_y_continuous("Velocity", expand = c(0,0.0))
graphVel = graphVel + ggtitle("Velocity of cloud" )	

tikz(file = "10MutsFlatVel.tex", width = 3, height = 3 )
print(graphVel)
dev.off()

graphVar = ggplot(data, aes(Time, Variance)) + geom_line()
graphVar = graphVar + theme_bw(base_size=10) + theme(  panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
graphVar = graphVar + theme(axis.ticks.length = unit(-0.25, "cm"),  axis.ticks.margin = unit(0.5, "cm"))	
graphVar = graphVar + theme(axis.title.y = element_text(vjust = 1.0))
graphVar = graphVar + scale_x_continuous("Time", expand = c(0,0))
graphVar = graphVar + scale_y_continuous("Standard Deviation", expand = c(0,0.0))
graphVar = graphVar + ggtitle("Standard Deviation of cloud" )	

tikz(file = "10MutsFlatVar.tex", width = 3, height = 3 )
print(graphVar)
dev.off()





