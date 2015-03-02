rm(list=ls())
library(ggplot2, tikzDevice)

smallH = read.csv("0.01_hTESTmesh0.1_deltaX.txt", sep = "\t", head = F)
bigH = read.csv("0.075_hTESTmesh0.1_deltaX.txt", sep = "\t", head = F)
simData = read.csv("160641483882148_Populations.txt", sep = "\t", head = F)

pdeTime = seq(0,199.99, by=0.01)
poisData = exp(-0.1*pdeTime)

par(mfrow=c(2,2))

k = 1
plot(simData$V1, simData[,k+1]/1000, type="l", ylim=c(0,1))
#matplot(exp(-0.1*simData$V1), type="l", col="red", add=T)
matplot(pdeTime, smallH[,k], type="l", col="green", add=T)
matplot(pdeTime, bigH[,k], type="l", col="blue", add=T)
k = 4
plot(simData$V1, simData[,k+1]/1000, type="l", ylim=c(0,1))
#matplot(exp(-0.1*simData$V1), type="l", col="red", add=T)
matplot(pdeTime, smallH[,k], type="l", col="green", add=T)
matplot(pdeTime, bigH[,k], type="l", col="blue", add=T)
k = 7
plot(simData$V1, simData[,k+1]/1000, type="l", ylim=c(0,1))
#matplot(exp(-0.1*simData$V1), type="l", col="red", add=T)
matplot(pdeTime, smallH[,k], type="l", col="green", add=T)
matplot(pdeTime, bigH[,k], type="l", col="blue", add=T)
k = 10
plot(simData$V1, simData[,k+1]/1000, type="l", ylim=c(0,1))
#matplot(exp(-0.1*simData$V1), type="l", col="red", add=T)
matplot(pdeTime, smallH[,k], type="l", col="green", add=T)
matplot(pdeTime, bigH[,k], type="l", col="blue", add=T)

deltaX = 0.1

h = seq(0.001, 1, by=0.001)

y1 = ( 1 - deltaX/h)
y2 = ( deltaX/(2*h) - 1) 

label = rep.int("i", length(h))	
label2 = rep.int("i+1", length(h))	

data1 = data.frame(h, y1, label)
data2 = data.frame(h, y2, label2)

colnames(data1) = c("h", "y", "label")
colnames(data2) = c("h", "y", "label")

data = rbind(data1, data2)

graph = ggplot(data, aes(x=h, y=y, colour=label)) + geom_line() + scale_y_continuous(limits = c(-1.5, 1), expand=c(0,0)) + geom_vline(xintercept=c(deltaX, deltaX/2), linetype="dashed") + geom_hline(yintercept = 0 )
graph = graph + theme_bw() + theme(  panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + ggtitle("The Relationship Between $Delta x$ and $h$") + scale_x_continuous("Discretisation Parameter, h", expand=c(0,0), limits = c(0, 0.5)) 





