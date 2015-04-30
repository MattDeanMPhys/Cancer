rm(list=ls())
library(ggplot2)
library(tikzDevice)
library(grid)

x = seq(1, 100, by=0.1)

y = exp( - (x-50)^2/525)

data = data.frame(x , y)

graph = ggplot(data, aes(x, y)) + geom_line() + theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_rect(colour = "black")) 

graph = graph + scale_x_continuous(expand=c(0,0), breaks = NULL) + scale_y_continuous(expand = c(0,0), breaks=NULL)

graph = graph + geom_vline(aes(xintercept = 50), linetype = "dashed")

graph = graph + geom_segment(aes(x=0, xend=50, y = 0.3, yend=0.3), arrow = arrow(length = unit(0.5, "cm")))
graph = graph + geom_segment(aes(x=50, xend=66.5, y = 0.6, yend=0.6), arrow = arrow(length = unit(0.5, "cm")))
graph = graph + annotate("text", x = 15, y = 0.35, label = "a")
graph = graph + annotate("text", x = 57, y = 0.65, label = "b")
graph = graph + ylab("Concentration")
graph = graph + xlab("Cell Type")


tikz("MotionDrawing.tex", width = 3, height = 3)
print(graph)
dev.off()
