library(ggplot2)
library(gtable)

rm(list=ls())

filename = list.files()[grep("Stat", list.files())]

data = read.csv(filename, sep = "\t" )

graphDisplacement = ggplot(data, aes(Time, Displacement)) + geom_line() + ggtitle(filename) 
graphVelocity = ggplot(data, aes(Time, Velocity)) + geom_line( se=F) + geom_smooth(se=F)
graphVariance = ggplot(data, aes(Time, Variance)) + geom_line()

graphDisplacement = graphDisplacement + theme(axis.ticks=element_blank(), axis.text.y = element_blank())
graphVelocity = graphVelocity + theme(axis.ticks=element_blank(), axis.text.y = element_blank())
graphVariance = graphVariance + theme(axis.ticks=element_blank(), axis.text.y = element_blank())

grphD = ggplotGrob(graphDisplacement)
grphVel = ggplotGrob(graphVelocity)
grphVar = ggplotGrob(graphVariance)
g = gtable:::rbind_gtable(grphD, grphVel, "first")
h = gtable:::rbind_gtable(g, grphVar, "first")

grid.newpage()
grid.draw(h)


