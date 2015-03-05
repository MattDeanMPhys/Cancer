rm(list=ls())
library(ggplot2)

phasePotrait <- function(u0, v0, c, h){

	df = data.frame(u, v, (u + h*v), (v + h * ( -(c+1) * v - u)) )
	names(df) = c("U", "V", "dU", "dV")

	return(df)
}



