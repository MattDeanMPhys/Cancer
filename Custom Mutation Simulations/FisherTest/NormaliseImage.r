rm(list=ls())
library(tikzDevice)
library(ggplot2)

posPop = read.csv("1514087213008365_Populations.txt", head = F, sep = "\t")
posStats = read.csv("1514087213008365_StatisticOutput.txt", head = T, sep = "\t")

i = 10

dataSnapPos = unlist(posPop[i,2:101])

dataSnapPos = dataSnapPos / max(dataSnapPos) #normalising step

comPos = posStats$Displacement[i]
dataSnapPosCOM = dataSnapPos[-(1:comPos)]

frame_1 = data.frame(c(1:length(dataSnapPosCOM)), dataSnapPosCOM, rep.int("t=1", length(dataSnapPosCOM)))
names(frame_1) = c("x", "u", "label")

i = 25

dataSnapPos = unlist(posPop[i,2:101])

dataSnapPos = dataSnapPos / max(dataSnapPos) #normalising step

comPos = posStats$Displacement[i]
dataSnapPosCOM = dataSnapPos[-(1:comPos)]

frame_2 = data.frame(c(1:length(dataSnapPosCOM)), dataSnapPosCOM, rep.int("t=25", length(dataSnapPosCOM)))
names(frame_2) = c("x", "u", "label")

i = 50

dataSnapPos = unlist(posPop[i,2:101])

dataSnapPos = dataSnapPos / max(dataSnapPos) #normalising step

comPos = posStats$Displacement[i]
dataSnapPosCOM = dataSnapPos[-(1:comPos)]

frame_3 = data.frame(c(1:length(dataSnapPosCOM)), dataSnapPosCOM, rep.int("t=50", length(dataSnapPosCOM)))
names(frame_3) = c("x", "u", "label")

frame = rbind(frame_1, frame_2, frame_3)

graph = ggplot(frame, aes(x = x, y = u, linetype = label)) + geom_line()

graph = graph + theme_bw() + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + scale_y_continuous(expand=c(0,0)) + scale_x_continuous(limits = c(1,25), expand=c(0,0))
graph = graph + theme(legend.position = c(0.7, 0.7))
graph = graph + theme(axis.title.y=element_text(vjust=0.1))
graph = graph + geom_point(aes(x=3.9, y=0.5))+ geom_point(aes(x=5.65, y=0.5))+geom_point(aes(x=8.73, y=0.5))

#tikz("unNormCOM.tex", width = 3, height = 3)
tikz("NormedCOM.tex", width = 3, height = 3)
print(graph)
dev.off()



