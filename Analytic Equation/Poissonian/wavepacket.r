poiswave <- function(t){ 

x = seq(0,100, 0.5) 

u = 0.1

rho = ((u*t)^x / gamma(x+1))*exp(-u*t)

if( (1-sum(rho)) < 0 ){
	rho[length(rho)] = 0 
}
else{

	rho[length(rho)] = 1 - sum(rho)
}

return(rho)

}


efData = read.csv("Euler_Forward_0-1_1_100_species.bin", sep = "\t", head = F)

efDataT = efData[-1]
efDataT = efDataT[-ncol(efDataT)]

quartz()
i = 1 


time = unlist(efData$V1)

#while(i < length(time)){

	plot(seq(0,100, 0.5), poiswave(time[i]), type= "l")

	matplot(c(0:99), unlist(efDataT[i,]), type = "l", add = T, col="red" )

	i = i + 1
}
