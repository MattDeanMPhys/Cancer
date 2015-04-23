rm(list=ls())
library(ggplot2)

posParams = read.csv("1514087213008365_Parameters.txt", head = F, sep = "\t")
negParams = read.csv("1517043321160289_Parameters.txt", head = F, sep = "\t")
posStats = read.csv("1514087213008365_StatisticOutput.txt", head = T, sep = "\t")
negStats = read.csv("1517043321160289_StatisticOutput.txt", head = T, sep = "\t")
posPop = read.csv("1514087213008365_Populations.txt", head = F, sep = "\t")
negPop = read.csv("1517043321160289_Populations.txt", head = F, sep = "\t")



#mutationScapePos = as.numeric(levels(posParams$V2[8:107]))
#mutationScapeNeg = as.numeric(levels(negParams$V2[8:107]))
#mutationScapePos = mutationScapePos[1:100]
#mutationScapeNeg = rev(mutationScapeNeg[1:100])

i = 2 
k = 2 

dispNeg = 0
dispPos = 0

while(i < 100){

	dataSnapPos = unlist(posPop[i,2:101])
	dataSnapPos = dataSnapPos / max(dataSnapPos) #normalising step

	comPos = posStats$Displacement[i]
	dataSnapPosCOM = dataSnapPos[-(1:comPos)]

	velCalcPosX = c(which(dataSnapPosCOM < 0.5)[1], which(dataSnapPosCOM <0.5)[1] -1)
	velCalcPosY = dataSnapPosCOM[velCalcPosX]
	interpPos = approx(velCalcPosY, velCalcPosX, xout = 0.5)	
	dispPos = c(dispPos, interpPos$y)
	

	if(tail(dataSnapPosCOM, n=1) != 0){
		break
	}

	i = i + 1
}

while(k < 500){
	dataSnapNeg = unlist(negPop[k,2:101])
	dataSnapNeg = dataSnapNeg / max(dataSnapNeg) #normalising step

	comNeg = negStats$Displacement[k]
	dataSnapNegCOM = dataSnapNeg[-(1:comNeg)]

	velCalcNegX = c(which(dataSnapNegCOM < 0.5)[1], which(dataSnapNegCOM <0.5)[1] -1)
	velCalcNegY = dataSnapNegCOM[velCalcNegX]
	interpNeg = approx(velCalcNegY, velCalcNegX, xout = 0.5)	
	dispNeg = c(dispNeg, interpNeg$y)
	

	if(tail(dataSnapNegCOM, n=1) != 0){
		break
	}

	k = k + 1
}


dispPos = dispPos[-1]
velPos = 0 
for(j in c(2:length(dispPos))){

	velPos = c(velPos, dispPos[j] - dispPos[j-1])

}

j = 0
dispNeg = dispNeg[-1]
velNeg = 0 
for(j in c(2:length(dispNeg))){

	velNeg = c(velNeg, dispNeg[j] - dispNeg[j-1])

}

framePos = data.frame(c(1:length(velPos)), velPos, rep.int("Pos", length(velPos)))
frameNeg = data.frame(c(1:length(velNeg)), velNeg, rep.int("Neg", length(velNeg)))

names(framePos) = c("Time", "Velocity", "Label")
names(frameNeg) = c("Time", "Velocity", "Label")

frame = rbind(framePos, frameNeg)

graph = ggplot(frame, aes(Time, Velocity, colour = Label)) + geom_line() + theme_bw() + geom_smooth()



