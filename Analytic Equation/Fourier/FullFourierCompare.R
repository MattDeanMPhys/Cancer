library(ggplot2)
rm(list=ls())

source("FourierSolution.R")




dat = read.csv("Euler_Forward_0-1_1_200_species.bin", sep = "\t", head = F)

time = unlist(dat$V1)

dat = dat[-1]
dat = dat[-ncol(dat)]

i = 2 
while(i < nrow(dat) ){

	plot(c(0:199), unlist(dat[i,]), type="l", lty=3)
	matplot(c(0:200), FourierSolution(200, time[i], 0.1, 1), add = T, type = "l")


	xAxis = c(c(0:199), c(0:200))

	analyticConcentrations = FourierSolution(200, time[i], 0.1, 1)
	efConcentrations = unlist(dat[i,])

	concentrationError = efConcentrations - analyticConcentrations
	xAxisError = c(0:200)

	dataError = data.frame(concentrationError, xAxisError)

	matplot(c(0:200), concentrationError, type="l", add=T)

	concentrations = c(efConcentrations ,analyticConcentrations  )
	
	lab = c( rep.int("EulerForward", 200), rep.int("Analytic", 201))

	data = data.frame(xAxis, concentrations, lab)

	graph = ggplot(data, aes(xAxis, concentrations, colour = lab)) + geom_line() + theme_bw() 
	graphError = ggplot(dataError, aes(xAxisError, concentrationError)) + geom_line() + theme_bw()

	print(i)

	i = i + 100

}


