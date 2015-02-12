rm(list=ls())

simData = read.csv("1790599216416588_Populations.txt", sep = "\t", head = F)

u = 0.1
deltaX = 0.1 

t = c(0:1500)

Poissonian <- function(u, t, n){


return(exp(-u*t) * (u*t)^n * ( 1/ factorial(n)))

}

Continuous <- function(u, deltaX, t, x){

return( (1/sqrt(2*pi*deltaX^2*u*t))*exp(- (deltaX*t*u - x)^2/(2*deltaX^2*u*t)))


}



i = 0
while(i < 150){

	pois = Poissonian(u, t, i)
	cont = Continuous(u, deltaX, t, i*deltaX)

	plot(simData[,i+2]/1000, ylim=c(0,0.2))
	matplot(pois, type="l", add=T)
	matplot(cont, type = "l", col = "red", add=T)

	i = i + 1 
}
