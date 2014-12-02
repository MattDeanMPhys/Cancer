FourierSolution <- function(numberOfMutations, time, u, deltaX){

	muts = seq(0, numberOfMutations * deltaX, deltaX) 

	utilde = u * deltaX 

	y = sqrt(1/(2*pi*deltaX*utilde*time)) *  exp(-( (utilde*time - muts )^2 / (2*deltaX*utilde*time)))

	return(y)

}
