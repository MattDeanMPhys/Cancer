rm(list=ls())
library(grid)
library(ggplot2)
library(tikzDevice)

fish = read.csv("test.txt", head = F, sep = "\t")

# plot(unlist(fish[1,]), type = "l")
# matplot(unlist(fish[nrow(fish)/4, ]), pch=3, col = "red", add=T)
# matplot(unlist(fish[nrow(fish)/2, ]), pch = 3, col = "red", add=T)
# matplot(unlist(fish[3*nrow(fish)/4, ]), pch = 3, col = "red", add=T)
# matplot(unlist(fish[nrow(fish), ]), pch=3, col = "blue", add=T)
deltax=0.5
test2 = log(unlist(fish[2*nrow(fish)/4,]))
fishFrame2 = data.frame(c(1:ncol(fish)*deltax), test2, rep.int("t=2", ncol(fish)*deltax))
names(fishFrame2) = c("x", "Population", "Time")

linstart = 40
linend = 46
linsec = log(unlist(fish[2*nrow(fish)/4,(linstart/deltax):(linend/deltax)]))
xt = seq(40,46,length.out=(length(linsec)))
res=lm(linsec~xt)

fishFrame = rbind(fishFrame2)

graph = ggplot(fishFrame, aes(x, Population, group=Time))  + geom_line() + theme_bw() + theme(panel.border = element_rect(colour = 
	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("$x$", expand=c(0,0), limits=c(20,60)) + scale_y_continuous("$log(u)$", expand=c(0,0))
#graph = graph + ggtitle("Fisher Waves")
graph = graph + geom_abline(intercept = 35.29, slope = -1, aes(color='red'))
tikz(file = "FisherWavesFKKP_logDean.tex", width = 3, height = 3)
print(graph)
dev.off()
