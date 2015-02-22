rm(list=ls())

statsData = read.csv("1093480131402113_StatisticOutput.txt", sep = "\t", head = T)
popData = read.csv("1093480131402113_Populations.txt", sep = "\t", head = F)
paramData = read.csv("1093480131402113_Parameters.txt", sep = "\t", head = F, as.is= T) 

mesh = read.csv("meshCos.txt", sep = "\t", head = F)

mutScape = paramData$V2[8:107]

i = 900 

while(i < 800){

	plot(unlist(popData[i,2:101]), type = "l", ylim = c(0, 100)) 
	
	print(sum(popData[i, 2:101]))

	i = i + 1
}

j =  150
#while(j < 400){
	
	par(mfrow = c(2,1))
	plot(unlist(popData[j,2:101]), type = "l", col = "red")
	matplot(unlist(mesh[j,]*100), type = "l", add = T)
	j = j + 1 


	plot(mutScape, type = "l")
	#plot(statsData$Displacement, type = "l")
	#plot(statsData$Variance, type = "l")
		
#}
