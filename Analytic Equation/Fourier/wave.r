generalwave <- function(C, alpha, beta, gamma, T){

	x = seq(0,100,1)
	
	t = 1 

	while(t < T){


		y = (C / sqrt(t) ) * exp(- ((alpha *t - beta*x)^2)/ (gamma * t))
		plot(x,y, type="l", ylim=c(0,1))
		t = t + 1 
	}
}

generalwave(1,0.1,1,0.1, 1000)
