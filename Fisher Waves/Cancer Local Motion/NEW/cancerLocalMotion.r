rm(list=ls())
library(ggplot2)
library(tikzDevice)



negStats = read.csv("3767796507356326_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3767780823707108_StatisticOutput.txt", head = T, sep = "\t")


negPop = read.csv("3767796507356326_Populations.txt", head = F, sep = "\t") 
posPop = read.csv("3767780823707108_Populations.txt", head = F, sep = "\t")


#Take the first time step, cut it to the COM and normalise.
#Then interpolate to find where the point where 0.5 concentration is. 

i = 5 

dispPos = 0 

while(i < 500){

	dataSnapPos = unlist(posPop[i, 2:101])
	dataSnapPos = dataSnapPos / max(dataSnapPos)

	comPos = posStats$Displacement[i]
	dataSnapPosCOM = dataSnapPos[-(1:comPos)]

	velCalcPosX = c(which(dataSnapPosCOM < 0.5)[1], which(dataSnapPosCOM < 0.5)[1] - 1 )
	velCalcPosY = dataSnapPosCOM[velCalcPosX]
	
	interpPos = approx(velCalcPosY, velCalcPosX, xout = 0.5)

	dispPos = c(dispPos, interpPos$y)

	if(tail(dataSnapPosCOM, n=1) != 0){

		break

	}


	i = i +1 
}

dispPos = dispPos[-1]
velPos = 0 

for(j in c(2:length(dispPos))){

	velPos = c(dispPos, dispPos[j] - dispPos[j-1])

}
velPos = velPos[-length(velPos)]
framePos = data.frame(c(1:length(velPos)), velPos, rep.int("Pos", length(velPos)))
names(framePos) = c("Time", "Velocity", "Label")

themeDean = theme_bw() + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
graph = ggplot(framePos, aes(Time, Velocity)) + geom_line()
graph = graph + themeDean + scale_x_continuous(expand=c(0,0)) + scale_y_continuous(expand=c(0,0))
graph = graph + ggtitle("$C > 0$, Local Motion")  

tikz("LocalMotionPos.tex", width = 3, height = 3)
print(graph)
dev.off()


