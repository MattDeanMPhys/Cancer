gaussol <- function(x, t){

	deltaX = 1 
	u = 0.1 
	u_tilde = deltaX * u 

	
	rho = ( (2*pi) / (deltaX * u_tilde * t)) ^(0.5) * exp( - ( u_tilde*t + 2* deltaX * t * u - 2*x + (x^2/(u_tilde * t))) / (2 * deltaX))

	return(rho)


}

gaussol_v2 <- function(x,t, deltaX, u, x0){

	#deltaX = 10 
	#u = 0.1 
	u_tilde = deltaX * u 
	#x0 = 0 
	
	rho = ( (2*pi) / (deltaX * u_tilde * t)) ^(0.5) * exp( - (u_tilde * t - x + x0)^2 / (2 * deltaX * u_tilde * t  ))

	return(rho)

}


