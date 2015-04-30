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

graphPos_ZOOM = graphPos + scale_x_continuous(limits = c(0, 100), expand=c(0,0)) + geom_smooth(fill = NA)
graphNeg_ZOOM = graphNeg + scale_x_continuous(limits = c(0, 150), expand=c(0,0)) + geom_smooth(fill = NA)


graphPos_TEST = graphPos + scale_x_continuous(limits = c(0, 250))
graphNeg_TEST = graphNeg + scale_x_continuous(limits = c(0, 400))

tikz("BulkMotionNeg.tex", width = 3, height = 3)
print(graphNeg_TEST)
dev.off()

tikz("BulkMotionPos.tex", width = 3, height = 3)
print(graphPos_TEST)
dev.off()

tikz("BulkMotionPosZOOM.tex", width = 3, height =3)
print(graphPos_ZOOM)
dev.off()

tikz("BulkMotionNegZOOM.tex", width = 3, height =3)
print(graphNeg_ZOOM)
dev.off()



