generalwave <- function(C, alpha, beta, gamma, T){

	x = seq(0,10,0.1)
	
<<<<<<< Updated upstream
	t = T 

	#while(t < T){


		y = (C / sqrt(t) ) * exp(- ((alpha *t - beta*x)^2)/ (gamma * t))
		plot(x,y, type="l", ylim=c(0,5)) 
		t = t + 1 
	#}
=======
	y = (C / sqrt(T) ) * exp(- ((alpha *T - beta*x)^2)/ (gamma * T))
	plot(x,y, type="l", ylim=c(0,1)) 


>>>>>>> Stashed changes
}

T = 50
u = 0.1
deltaX = 1
uTilde = u*deltaX

c = sqrt(2*pi/(deltaX*uTilde))
alph = uTilde
gam = 2* deltaX * uTilde

generalwave(c, alph, 1, gam, 1000)

simData = read.csv("temp.bin", sep = "\t", head = F)
Tpop = which(simData$V1 > T)

simData = simData[-1]
simData = simData[-ncol(simData)]
cellTypes = c(0:99)

<<<<<<< Updated upstream
cellTypes = c(0:9)

T = 10
#while(T < 1000){
	pops = unlist(simData[T,]/1000)
	
	generalwave(c,alph,1,gam, T)
	matplot(cellTypes, pops, type="l",lty=2, add=T, ylim=c(0,10))

	#T = T + 1
=======
pops = unlist(simData[Tpop[1]-1,])
	
generalwave(c, alph, 1, gam, T)
matplot(cellTypes, pops, type="l", lty=2, add=T, ylim=c(0,1))
>>>>>>> Stashed changes

