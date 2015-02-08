uHat <- function(x, A, B, deltaX){

	a = A * exp((- (1) + sqrt(1 + 2 * deltaX))*(x/deltaX))
	b = B * exp(-( (1) + sqrt(1 + 2 * deltaX))*(x/deltaX))

	return(a+b)

}
