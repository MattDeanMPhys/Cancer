rm(list=ls())
library(ggplot2)
library(grid)
library(tikzDevice)
library(filehash)


flatData = read.csv("1790599216416588_StatisticOutput.txt", sep = "\t")
trapData = read.csv("1791403055027814_StatisticOutput.txt", sep = "\t")
antiTrapData = read.csv("1827113733698289_StatisticOutput.txt", sep = "\t")



trapGraph = ggplot(trapData, aes(Time, Displacement )) + geom_line() + geom_line(data = flatData, aes(Time, Displacement), linetype= "dashed")
trapGraph = trapGraph + theme_bw(base_size=10)
trapGraph = trapGraph + theme(panel.border = element_rect(colour="black"))
trapGraph = trapGraph + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
trapGraph = trapGraph + theme(axis.ticks.length = unit(0.15, "cm"), axis.ticks.margin = unit(0.15, "cm"))
trapGraph = trapGraph + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(limits = c(0, 50), expand=c(0,0))
trapGraph = trapGraph + ggtitle("Displacement \n of a Fitness Trap")

trapGraphVar = ggplot(trapData, aes(Time, Variance )) + geom_line() + geom_line(data = flatData, aes(Time, Variance), linetype= "dashed")
trapGraphVar = trapGraphVar + theme_bw(base_size=10)
trapGraphVar = trapGraphVar + theme(panel.border = element_rect(colour="black"))
trapGraphVar = trapGraphVar + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
trapGraphVar = trapGraphVar + theme(axis.ticks.length = unit(0.15, "cm"), axis.ticks.margin = unit(0.15, "cm"))
trapGraphVar = trapGraphVar + scale_x_continuous(expand=c(0,0)) + scale_y_continuous( expand=c(0,0))
trapGraphVar = trapGraphVar + ggtitle("Standard Deviation \n  of a Fitness Trap")


antiTrapGraph = ggplot(antiTrapData, aes(Time, Displacement )) + geom_line() + geom_line(data = flatData, aes(Time, Displacement), linetype= "dashed")
antiTrapGraph = antiTrapGraph + theme_bw(base_size=10)
antiTrapGraph = antiTrapGraph + theme(panel.border = element_rect(colour="black"))
antiTrapGraph = antiTrapGraph + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
antiTrapGraph = antiTrapGraph + theme(axis.ticks.length = unit(0.15, "cm"), axis.ticks.margin = unit(0.15, "cm"))
antiTrapGraph = antiTrapGraph + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(limits = c(0, 50), expand=c(0,0))
antiTrapGraph = antiTrapGraph + ggtitle("Displacement \n of a Fitness Anti-Trap")

antiTrapGraphVar = ggplot(antiTrapData, aes(Time, Variance )) + geom_line() + geom_line(data = flatData, aes(Time, Variance), linetype= "dashed")
antiTrapGraphVar = antiTrapGraphVar + theme_bw(base_size=10)
antiTrapGraphVar = antiTrapGraphVar + theme(panel.border = element_rect(colour="black"))
antiTrapGraphVar = antiTrapGraphVar + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
antiTrapGraphVar = antiTrapGraphVar + theme(axis.ticks.length = unit(0.15, "cm"), axis.ticks.margin = unit(0.15, "cm"))
antiTrapGraphVar = antiTrapGraphVar + scale_x_continuous(expand=c(0,0)) + scale_y_continuous( expand=c(0,0))
antiTrapGraphVar = antiTrapGraphVar + ggtitle("Standard Deviation \n  of a Fitness Anti-Trap")

tikz(file = "trapGraphDisp.tex", width = 3, height = 3)
print(trapGraph)
dev.off()

tikz(file= "trapGraphVar.tex", width = 3, height = 3)
print(trapGraphVar)
dev.off()

tikz(file = "antiTrapGraphDisp.tex", width = 3, height = 3)
print(antiTrapGraph)
dev.off()

tikz(file = "antiTrapGraphVar.tex", width =3, height = 3)
print(antiTrapGraphVar)
dev.off()



