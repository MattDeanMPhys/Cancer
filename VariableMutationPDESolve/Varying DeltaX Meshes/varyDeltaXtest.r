rm(list=ls())

fileList = list.files()

meshFiles = grep("mesh", fileList, value = T)

simData = read.csv("1790599216416588_Populations.txt", sep = "\t", head = F)
simData = simData[, 1:ncol(simData)-1]

baseData = read.csv(meshFiles[3], sep = "\t", head = F)
t = seq(0, 15, by=0.01)

j = 5

quartz()

plot(seq(0,751.5, by=0.5),baseData[,j], type="l")

for(i in c(4:9)){


	data = read.csv(meshFiles[i], sep = "\t", head = F)

	matplot(seq(0,751.5, by=0.5), data[,j], type = "l", add = T)


}

matplot(simData[,j+1]/1000, type = "l", col = "red", add = T)


#for(i in c(1:nrow(baseData))){
#	plot(seq(0,1, length.out=100)*50, unlist(baseData[i,]), type = "l")
#	matplot(unlist(simData[i, 2:51])/1000, type = "l", add = T, col="red")
#
#}

