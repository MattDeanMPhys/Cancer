rm(list=ls())
library(tikzDevice)
library(ggplot2)


negStats = read.csv("3767796507356326_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3767780823707108_StatisticOutput.txt", head = T, sep = "\t")

themeDean = theme_bw() + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 

graphPos = ggplot(posStats, aes(Time, Velocity)) + geom_line() + themeDean + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))
graphNeg = ggplot(negStats, aes(Time, Velocity)) + geom_line()  + themeDean + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand = c(0,0))

graphNeg = graphNeg + ggtitle("Bulk Motion, $C < 0$")
graphPos = graphPos + ggtitle("Bulk Motion, $C > 0$")

tikz("BulkMotionNeg.tex", width = 3, height = 3)
print(graphNeg)
dev.off()

tikz("BulkMotionPos.tex", width = 3, height = 3)
print(graphPos)
dev.off()


