generalwave <- function(C, alpha, beta, gamma, T){

	x = seq(0,100,0.1)
	
	t = 1 

	while(t < T){


		y = (C / sqrt(t) ) * exp(- ((alpha *t - beta*x)^2)/ (gamma * t))
		plot(x,y, type="l", ylim=c(0,5)) 
		t = t + 1 
	}
}

T = 250
u = 0.01
deltaX = 1
uTilde = u*deltaX

c = sqrt(2*pi/(deltaX*uTilde))
alph = uTilde
gam = 2* deltaX * uTilde


generalwave(c, alph, 1, gam, 1000)

simData = read.csv("332618708717554_Populations.txt", sep = "\t", head = F)

simData = simData[c("V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11")]

cellTypes = c(0:9)

T = 1
#while(T < 1000){
	#pops = unlist(simData[T,]/1000)
	
	#generalwave(c,alph,1,gam, T)
	#matplot(cellTypes, pops, type="l",lty=2, add=T, ylim=c(0,10))

	#T = T + 1

#}
