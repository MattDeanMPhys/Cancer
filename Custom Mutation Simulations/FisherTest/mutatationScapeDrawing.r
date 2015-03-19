rm(list=ls())
library(ggplot2)
library(tikzDevice)

x = seq(0, 1, by = 0.001)

DeltaX = 1/50

uPos = 0.5*x + 0.5 - (DeltaX/2)*exp(-2*x/DeltaX)
uNeg = -0.5*x + 0.5 - (DeltaX/2)*exp(-2*x/DeltaX)

data = data.frame(c(x,x), c(uPos, uNeg), c(rep.int("Increasing", length(x)), rep.int("Decreasing", length(x))))
names(data) = c("x", "Probability", "Label")

graph = ggplot(data, aes(x, Probability, linetype = Label)) + geom_line() + theme_bw() + theme(legend.title = element_blank(), legend.position = c(0.7, 0.5))
graph = graph + theme(  panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + scale_y_continuous("Mutation Probability", expand = c(0,0)) + scale_x_continuous("$x$", expand = c(0,0))

tikz(file = "MutationLandscape.tex", width = 3, height = 3)
print(graph)
dev.off()


