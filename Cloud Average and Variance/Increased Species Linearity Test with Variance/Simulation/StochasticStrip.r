rm(list=ls())

StochasticStrip = function(x){


	maxIndex = which( x$Displacement == max(x$Displacement)) 

	x = x[1:maxIndex,]

	
	write.table(x, "Stripped_flat_20muts.txt", sep = "\t")

	return(x)


}


data = read.csv("Statistic_Output_flat_20muts.txt", sep = "\t")


StochasticStrip(data)


