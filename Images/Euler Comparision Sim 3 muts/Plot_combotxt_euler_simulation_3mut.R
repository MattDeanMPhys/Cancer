library(ggplot2)
library(tikzDevice)
library(grid)
rm(list=ls())

data = read.csv("combo.txt", sep = "\t", head= F )
b = which(data[,1] == 0)
time =  data[b[1]:b[2]-1,1]
datae = data[b[1]:b[2]-1,2:4]
dataa = data[b[2]:nrow(data),2:4]

datafin = data.frame(0,0,0)
names(datafin) = c("Time", "Population", "Label")
tempdat = data.frame(time, datae[,1], rep('one', length(time) ) )
names(tempdat) = c("Time", "Population", "Label")
datafin<-rbind(datafin, tempdat)
tempdat = data.frame(time, datae[,2], rep('two', length(time) ) )
names(tempdat) = c("Time", "Population", "Label")
datafin<-rbind(datafin, tempdat)
tempdat = data.frame(time, datae[,3], rep('three', length(time) ) )
names(tempdat) = c("Time", "Population", "Label")
datafin<-rbind(datafin, tempdat)
datafin2 = data.frame(0,0,0)
names(datafin2) = c("Time", "Population", "Label")
tempdat = data.frame(time, dataa[,1], rep('one', length(time) ) )
names(tempdat) = c("Time", "Population", "Label")
datafin2<-rbind(datafin2, tempdat)
tempdat = data.frame(time, dataa[,2], rep('two', length(time) ) )
names(tempdat) = c("Time", "Population", "Label")
datafin2<-rbind(datafin2, tempdat)
tempdat = data.frame(time, dataa[,3], rep('three', length(time) ) )
names(tempdat) = c("Time", "Population", "Label")
datafin2<-rbind(datafin2, tempdat)
 
	datafin = datafin[-1,]
	datafin2 = datafin2[-1,]
	graph = ggplot(datafin2, aes(Time, Population, group=Label)) + geom_line(colour="gray53")
	graph = graph + geom_line(data = datafin, aes(Time, Population, group=Label), colour="black", linetype="dashed")
	graph = graph + theme_bw(base_size=10) + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
	graph = graph + theme(axis.ticks.length = unit(0.15, "cm"),  axis.ticks.margin = unit(0.15, "cm"))	
	graph = graph + theme(axis.title.y = element_text(vjust = 1.0))
	graph = graph + scale_x_continuous("Time", expand = c(0,0))
	graph = graph + scale_y_continuous(limits = c(0,1), "Population Number", expand = c(0,0))
	graph = graph + ggtitle("Simulation and Euler")	
	fileName = "test.tex"
	tikz(file=fileName, width = 3, height = 3)
	print(graph)
	dev.off()

# The datafin2 is the simulation dataframe, whilst datafin is the Euler dataframe.