rm(list=ls())
library(grid)
library(ggplot2)
library(tikzDevice)

fish = read.csv("meshDean.txt", head = F, sep = "\t")

plot(unlist(fish[1,]), type = "l")
matplot(unlist(fish[nrow(fish)/4, ]), pch=3, col = "red", add=T)
matplot(unlist(fish[nrow(fish)/2, ]), pch = 3, col = "red", add=T)
matplot(unlist(fish[3*nrow(fish)/4, ]), pch = 3, col = "red", add=T)
matplot(unlist(fish[nrow(fish), ]), pch=3, col = "blue", add=T)

test1 = unlist(fish[1,])
fishFrame1 = data.frame(c(1:100), test1, rep.int("t=0", 100))
names(fishFrame1) = c("x", "Population", "Time")

test2 = unlist(fish[nrow(fish)/3,])
fishFrame2 = data.frame(c(1:100), test2, rep.int("t=2", 100))
names(fishFrame2) = c("x", "Population", "Time")

test3 = unlist(fish[2*nrow(fish)/3,])
fishFrame3 = data.frame(c(1:100), test3, rep.int("t=3", 100))
names(fishFrame3) = c("x", "Population", "Time")

test4 = unlist(fish[nrow(fish),])
fishFrame4 = data.frame(c(1:100), test4, rep.int("t=4", 100))
names(fishFrame4) = c("x", "Population", "Time")


fishFrame = rbind(fishFrame1, fishFrame2, fishFrame3, fishFrame4)


graph = ggplot(fishFrame, aes(x, Population, group=Time))  + geom_line() + theme_bw() + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("$x$", expand=c(0,0)) + scale_y_continuous("$u$", expand=c(0,0), limits = c(0,1.05))
graph = graph + geom_segment(aes(x = 29, xend = 45, y = 0.5, yend = 0.5), size=0.5, arrow = arrow(length = unit(0.25, "cm"))) 
graph = graph + ggtitle("Illustration of Fisher Waves")
graph = graph + annotate("text", x = 40, y = 0.55, label = "Wave Velocity")

tikz(file = "FisherWavesFKKP.tex", width = 3, height = 3)
print(graph)
dev.off()
