rm(list=ls())
ef_data = read.csv("Euler_Forward_0-1_1_100_species.bin", sep = "\t", head=F)

fourierSolution <- function(x, t, u, deltaX){

	muts = c(0:x) 

	utilde = u * deltaX

	y = (1/(2*pi))* ( sqrt(2*pi/ (t*utilde*deltaX) ) * exp(- ( utilde*t - muts)^2 /(2*deltaX*utilde*t)))


	return(y)

}
NEWfourierSolution <- function(x, t, u, deltaX){
#THIS IS WRONG PROVEN THAT DOESN"T SOLVE THE PDE
	muts = c(0:x) 

	utilde = u * deltaX

	y = exp(- ( utilde*t - muts)^2 /(2*deltaX*utilde*t)) * exp(-0.5)


	return(y)

}

NEW2fourierSolution <- function(I, t, u, deltaX){


	xMax = I*deltaX

	muts = seq(0, I*deltaX, deltaX)

	utilde = u * deltaX

	y =  (1/(2*pi))*( sqrt(2*pi/ (t*utilde*deltaX) ) * exp(- ( utilde*t - muts)^2 /(2*deltaX*utilde*t)))


	return(y)

}



X = ncol(ef_data) - 2
ef_data_trimmed = ef_data[-1]
ef_data_trimmed = ef_data_trimmed[-ncol(ef_data)]


T = 1
TMAX= 10000
deltaX = 1

time = unlist(ef_data$V1)

time = time[0:700]

i = 2 

efMaxes = 0
anMaxes = 0 
newanMaxes = 0

while(i < length(time)){

#	bins = c(0:X)
#	pop = c(unlist(ef_data_trimmed[i,]), fourierSolution(X, time[i], 1, deltaX))
#	label = c(rep.int("EF", length(unlist(ef_data_trimmed[i,]))), rep.int("Analytic", length(fourierSolution(X, time[i], 1, deltaX))))

#	data = data.frame(bins, pop, label)


#	graph = ggplot(data, aes(bins, pop, colour = label)) + geom_line() + theme_bw() + xlab("Mutations") + ylab("Concentrations") + ggtitle("Comparing Euler Forward and Analytic Result")


#	graph = graph + annotate("text", x =90, y =0.1, label = paste("T = ", time[i]))


	#plot(c(0:X), fourierSolution(X, time[i], 1, deltaX), col = "red", type="l", ylim=c(0,1))
	#matplot(c(0:X), NEWfourierSolution(X, time[i], 1, deltaX), col = "blue", type="l", add = T)
	#matplot(c(0:X), unlist(ef_data_trimmed[i,]),pch=1, type="o", add=T)
	#matplot(c(0:X), NEW2fourierSolution(100, time[i], 1,deltaX), type="l", col="black", add=T)

	plot(c(0:X), NEW2fourierSolution(100, time[i], 1, deltaX), type = "l" )
	#matplot(c(0:X), NEW2fourierSolution(100, time[i], 1, deltaX/10),col = "blue", type = "l", add=T)
	#matplot(c(0:X), NEW2fourierSolution(100, time[i], 1, deltaX*6), col = "red", type = "l", add=T)
	#matplot(c(0:X), NEW2fourierSolution(100, time[i], 1, deltaX/1000), col = "green", type = "l", add=T)
	matplot(c(0:X), unlist(ef_data_trimmed[i,]),pch=1, type="o", add=T)

	efMaxes = c(efMaxes, max( unlist(ef_data_trimmed[i,]), na.rm=T))
	anMaxes = c(anMaxes, max(fourierSolution(X, time[i], 1, deltaX), na.rm=T))
	newanMaxes = c(newanMaxes, max(NEWfourierSolution(X, time[i], 1, deltaX), na.rm=T))


	i = i + 10
}


#Peak analysis of the analytic and ef data. 

max_ratios = anMaxes/efMaxes
Newmax_ratios = newanMaxes/efMaxes





