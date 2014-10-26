library(ggplot2)

source("StochasticStrip_V2.r")

flat = read.csv("Statistic_Output_flat_30muts_1000cells.txt", sep = "\t")
antitrap = read.csv("Statistic_Output_antitrap_30muts_1000cells.txt", sep = "\t")

flat = StripV2(flat)
antitrap = StripV2(antitrap)


fullData = rbind(flat, antitrap)

displacementGraph = ggplot(fullData, aes(Time, Displacement, colour = Label)) + geom_line()


velocityGraph = ggplot(fullData, aes(Time, Velocity, colour = Label)) + geom_smooth(se= F)


varianceGraph = ggplot(fullData, aes(Time, Variance, colour = Label)) + geom_smooth(se= F)
