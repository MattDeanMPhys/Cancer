rm(list=ls())
library(ggplot2)

simData = read.csv("160641483882148_Populations.txt", sep = "\t", head = F) 

files = list.files()

meshes = grep("hTEST",files, value = T)

baseData = read.csv(meshes[1], sep = "\t", head = F)

j = 1
dataFrame = data.frame(seq(0, 200, length.out=length(baseData[,j])), baseData[,j], rep.int(strsplit(meshes[1], "[_]")[[1]][[1]], length(baseData[,j])))
names(dataFrame) = c("Time", "Values", "Label")


for( i in c(2:length(meshes))){

	data = read.csv(meshes[i], sep = "\t", head = F)
	frame = data.frame(seq(0, 200, length.out=length(data[,j])), data[,j], rep.int(strsplit(meshes[i], "[_]")[[1]][[1]], length(data[,j])))
 	names(frame) = c("Time", "Values", "Label")
	
	dataFrame = rbind(dataFrame, frame)

} 

x = simData$V1[1:200]
y = simData[1:200,j+1]/1000
simFrame = data.frame(x,y)


graph = ggplot(dataFrame, aes(Time, Values, colour=Label)) + geom_line() + geom_line(data=simFrame, aes(x=x,y=y), color='black')
