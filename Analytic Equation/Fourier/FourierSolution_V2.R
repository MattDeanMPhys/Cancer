rm(list=ls())
FourierSolution <- function(numberOfMutations, time, u, deltaX){

	muts = seq(0, numberOfMutations, 0.001) 

	utilde = u * deltaX 

	y = deltaX * sqrt(1/(2*pi*deltaX*utilde*time)) * exp(-( (utilde*time - (muts/numberOfMutations) )^2 / (2*deltaX*utilde*time)))

	return(y)

}


simData = read.csv("1790599216416588_Populations.txt", sep = "\t", head = F)
ratio = 0
t=  1
while(t < 1000){
	analyticData = FourierSolution(50, t, 0.1, 1/50)

	plot( unlist(simData[t,2:51 ])/1000, ylim= c(0,1))
	matplot(seq(0, 50, length = length(analyticData)), analyticData, type="l", add = T)
	abline(v = seq(0, 50, length = length(analyticData))[which.max(analyticData)])

	ratio = c(ratio, max(analyticData) / max(unlist(simData[t,2:51]/1000)))


	t =  t + 1 
}

