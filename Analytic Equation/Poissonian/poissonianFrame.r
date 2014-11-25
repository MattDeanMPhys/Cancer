poissonianFrame <- function(N, T, U) { 

	pois = function(n,t,u) {


		return( 
		
			(((u*t)^n * exp(- u *t) ) / factorial(n))

		)

	}

	pois_last = function(Nfinal,t,u){

		sum = 0		
		n=0
		while(n < Nfinal){
			
			sum = sum + pois(n,t,u)
			n = n + 1
		}

		return(
			1 - sum
		)

	}


	u = U
	t = c(0:T)
	df = data.frame(t, pois(0, t, u), rep.int(0, length(t)))
	n = 1

	names(df) = c("Time", "Pop", "Species")

	while(n < N) {

		newDF =  data.frame(t, pois(n, t, u), rep.int(n, length(t)))

		names(newDF) = c("Time", "Pop", "Species")

		df = rbind(df,  newDF)

		n = n +1 
		
	}

	lastDF = data.frame(t, pois_last(N, t, u), rep.int(N, length(t)))

	names(lastDF) = c("Time", "Pop", "Species")

	df = rbind(df,  lastDF)
	return(df)
}

rm(list=setdiff(ls(), "poissonianFrame"))
