rm(list=ls())
library(tikzDevice)
library(ggplot2)


negStats = read.csv("3712388518298864_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3712396145837594_StatisticOutput.txt", head = T, sep = "\t")


themeDean = theme_bw() + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 

graphPos = ggplot(posStats, aes(Time, Velocity)) + geom_line() + themeDean + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))
graphNeg = ggplot(negStats, aes(Time, Velocity)) + geom_line()  + themeDean + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))

graphNeg = graphNeg +  ggtitle("Bulk Motion, $C<0$")
graphPos = graphPos + ggtitle("Bulk Motion, $C<0$")


