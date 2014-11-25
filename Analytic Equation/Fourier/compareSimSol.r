rm(list=ls())
ef_data = read.csv("Euler_Forward_0-1_1_100_species.bin", sep = "\t", head=F)

fourierSolution <- function(x, t, u, deltaX){

	muts = seq(0,x, deltaX)

	utilde = u * deltaX

	y = ( sqrt(2*pi/ (t*utilde*deltaX) ) * exp(- ( utilde*t - muts)^2 /(2*deltaX*utilde*t)))


	return(y)

}

X = ncol(ef_data) - 2
ef_data_trimmed = ef_data[-1]
ef_data_trimmed = ef_data_trimmed[-ncol(ef_data)]


T = 1
TMAX= 10000
deltaX = 1

time = unlist(ef_data$V1)

i = 2 
while(i < length(time)){

	plot(seq(0,X, deltaX), fourierSolution(X, time[i], 0.1, deltaX), col = "red", type="l")
	matplot(c(0:X), unlist(ef_data_trimmed[i,]), type="l", add=T)

	i = i +1
}
