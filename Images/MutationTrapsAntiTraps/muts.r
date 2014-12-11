rm(list=ls())
library(ggplot2)
library(tikzDevice)
library(grid)


trapData = read.csv("trapdata.txt", header=T, sep="\t")
antiTrapData = read.csv("antitrapdata.txt", header=T, sep="\t")
flatData = read.csv("data.txt", header=T, sep="\t")

themeBase = theme_bw(base_size=10) + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.ticks.length = unit(0.15, "cm"), axis.ticks.margin = unit(0.15, "cm")) 


trapDispGraph = ggplot(trapData, aes(Time, Displacement)) + geom_line() + geom_line(data = flatData, aes(Time, Displacement), linetype='dashed') + themeBase
trapDispGraph = trapDispGraph  +  scale_x_continuous(expand = c(0,0)) + scale_y_continuous(expand = c(0,0), limits = c(0,50))
trapDispGraph = trapDispGraph  + ggtitle("Displacement \n of a Mutation Trap")

trapVarGraph =  ggplot(trapData, aes(Time, Variance)) + geom_line() + geom_line(data = flatData, aes(Time, Variance), linetype='dashed') + themeBase
trapVarGraph = trapVarGraph  +  scale_x_continuous(expand = c(0,0)) + scale_y_continuous(expand = c(0,0))
trapVarGraph = trapVarGraph  + ggtitle("Standard Deviation \n of a Mutation Trap")

antiTrapDispGraph = ggplot(antiTrapData, aes(Time, Displacement)) + geom_line() + geom_line(data = flatData, aes(Time, Displacement), linetype='dashed') + themeBase
antiTrapDispGraph = antiTrapDispGraph  +  scale_x_continuous(expand = c(0,0)) + scale_y_continuous(expand = c(0,0), limits = c(0,50))
antiTrapDispGraph = antiTrapDispGraph  + ggtitle("Displacement \n of a Mutation Anti-Trap")

antiTrapVarGraph =  ggplot(antiTrapData, aes(Time, Variance)) + geom_line() + geom_line(data = flatData, aes(Time, Variance), linetype='dashed') + themeBase
antiTrapVarGraph = antiTrapVarGraph  +  scale_x_continuous(expand = c(0,0)) + scale_y_continuous(expand = c(0,0))
antiTrapVarGraph = antiTrapVarGraph  + ggtitle("Standard Deviation \n of a Mutation Anti-Trap")


tikz(file = "mutTrapDispGraph.tex", width = 3, height = 3)
print(trapDispGraph)
dev.off()

tikz(file = "mutiAntiTrapDispGraph.tex", width = 3, height = 3)
print(antiTrapDispGraph)
dev.off()

tikz(file = "mutTrapVarGraph.tex", width = 3, height = 3)
print(trapVarGraph)
dev.off()

tikz(file = "mutAntiTrapVarGraph.tex", width = 3, height = 3)
print(antiTrapVarGraph)
dev.off()








