rm(list=ls())
library(ggplot2)
library(tikzDevice)

negStats = read.csv("3767796507356326_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3767780823707108_StatisticOutput.txt", head = T, sep = "\t")


negPop = read.csv("3767796507356326_Populations.txt", head = F, sep = "\t") 
posPop = read.csv("3767780823707108_Populations.txt", head = F, sep = "\t")




#Take the first time step, cut it to the COM and normalise.
#Then interpolate to find where the point where 0.5 concentration is. 

i = 4

dispNeg = 0 

while(i < nrow(negPop)){

	dataSnapNeg = unlist(negPop[i, 2:101])
	dataSnapNeg = dataSnapNeg / max(dataSnapNeg)

	comNeg = negStats$Displacement[i]
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

velNeg = velNeg[-length(velNeg)]

frameNeg = data.frame(c(1:length(velNeg)), velNeg, rep.int("Neg", length(velNeg)))
names(frameNeg) = c("Time", "Velocity", "Label")

themeDean = theme_bw() + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
graph = ggplot(frameNeg, aes(Time, Velocity)) + geom_line()
graph = graph + themeDean + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand=c(0,0))
graph = graph + ggtitle("$C < 0$, Local Motion")  

tikz("LocalMotionNeg.tex", width = 3, height = 3)
print(graph)
dev.off()



