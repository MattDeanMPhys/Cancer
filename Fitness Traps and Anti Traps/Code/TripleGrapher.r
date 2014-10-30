library(ggplot2)
library(gtable)

rm(list=ls())

filename = list.files()[grep("Stat", list.files())]

data = read.csv(filename, sep = "\t" )

graphDisplacement = ggplot(data, aes(Time, Displacement)) + geom_line() + ggtitle(filename) + theme_bw() 
graphVelocity = ggplot(data, aes(Time, Velocity)) + geom_line( se=F) + geom_smooth(se=F) + theme_bw() 
graphVariance = ggplot(data, aes(Time, Variance)) + geom_line() + theme_bw() 

graphDisplacement = graphDisplacement + theme(axis.ticks=element_blank(), axis.text.y = element_blank(),axis.title.x = element_blank())
graphVelocity = graphVelocity + theme(axis.ticks=element_blank(), axis.text.y = element_blank(), axis.title.x = element_blank())
graphVariance = graphVariance + theme(axis.ticks=element_blank(), axis.text.y = element_blank())


graphDisplacement = graphDisplacement + scale_x_continuous( expand = c(0,0))
graphVelocity = graphVelocity + scale_x_continuous( expand = c(0,0))
graphVariance = graphVariance + scale_x_continuous( expand = c(0,0))


grphD = ggplotGrob(graphDisplacement)
grphVel = ggplotGrob(graphVelocity)
grphVar = ggplotGrob(graphVariance)
g = gtable:::rbind_gtable(grphD, grphVel, "first")
h = gtable:::rbind_gtable(g, grphVar, "first")

grid.newpage()
grid.draw(h)


