rm(list=ls())
library(ggplot2)
library(tikzDevice)


FixTime_1 =  read.csv("3712388518298864_FixationTimes.txt", head = F, sep = "\t")
FixTime_2 = read.csv("3712396145837594_FixationTimes.txt", head = F, sep = "\t")

negStats = read.csv("3712388518298864_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3712396145837594_StatisticOutput.txt", head = T, sep = "\t")

negPop = read.csv("3712388518298864_Populations.txt", head = F, sep = "\t") 
posPop = read.csv("3712396145837594_Populations.txt", head = F, sep = "\t")


#Take the first time step, cut it to the COM and normalise.
#Then interpolate to find where the point where 0.5 concentration is. 

i = 4 

dispNeg = 0 

while(i < 500){

	dataSnapNeg = unlist(negPop[i, 2:101])
	dataSnapNeg = dataSnapNeg / max(dataSnapNeg)

	comNeg = posStats$Displacement[i]
	dataSnapNegCOM = dataSnapNeg[-(1:comNeg)]

	velCalcNegX = c(which(dataSnapNegCOM < 0.5)[1], which(dataSnapNegCOM < 0.5)[1] - 1 )
	velCalcNegY = dataSnapNegCOM[velCalcNegX]
	
	interpNeg = approx(velCalcNegY, velCalcNegX, xout = 0.5)

	dispNeg = c(dispNeg, interpNeg$y)

	if(tail(dataSnapNegCOM, n=1) != 0){

		break

	}


	i = i +1 
}

dispNeg = dispNeg[-1]
velNeg = 0 

for(j in c(2:length(dispNeg))){

	velNeg = c(dispNeg, dispNeg[j] - dispNeg[j-1])

}

frameNeg = data.frame(c(1:length(velNeg)), velNeg, rep.int("Neg", length(velNeg)))
names(frameNeg) = c("Time", "Velocity", "Label")

graph = ggplot(frameNeg, aes(Time, Velocity)) + geom_line()





