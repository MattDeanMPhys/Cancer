rm(list=ls())
library(ggplot2)

files = list.files()

data = read.csv(grep("Populations", files, value=T), sep = "\t", head = F)

i = 1
while(i < nrow(data)){

	rawData = unlist(data[i, 2:11])
	maxPos = which.max(rawData)
	maxVal = max(rawData)

	normData = rawData/maxVal
	
	j = 1

	plot(normData, type="l")

	while(j < maxPos){
	
		normData[j] = 1 
		j = j + 1

	}

	matplot(normData, type = "l", add=T, col="red")
	

	#plot(unlist(data[i, 2:11]), type = "l")

	i = i +1
}

