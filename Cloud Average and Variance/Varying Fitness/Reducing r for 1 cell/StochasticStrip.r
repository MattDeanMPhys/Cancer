StochasticStrip = function(x){


	maxIndex = which( x$V2 == max(x$V2)) 

	x = x[1:maxIndex,]

	
	write.table(x, "Stripped_flat.txt", sep = "\t")

	return(x)


}


data = read.csv("Statistic_Output_flat.txt", sep = "\t", head = F)


StochasticStrip(data)


