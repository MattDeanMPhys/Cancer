rm(list=ls())
library(ggplot2)
library(grid)

phaseSpace <- function(u0, v0, h, c){
	u = c(u0)
	v = c(v0)

	i = 1
	while( i < 35){

		u = c(u, u[i] + h *v[i])
		v = c(v, v[i] + h*(-c*v[i] - u[i] * (1 - u[i] )))


		i = i + 1
	}

	label = paste( "(" , u0 , "," , v0 , ")" )

	frame = data.frame(u,v, rep.int(label, length(u)))
	names(frame) = c("U", "V", "label")
	return(frame)

}

#df = phaseSpace(3, 0, 0.01, 1)

j =1 
for(j in c(1:20)){
	for(k in c(1:20)){


	#df = rbind(df, phaseSpace(j*0.1, k*0.1, 0.01, 1))


	}
}

#graph = ggplot(df, aes(U, V, group=label))  + geom_line(alpha=0.5) 


phasePotrait2 <- function(u, v, h, c){

	df = data.frame(u, v, (u + h*v), (v + h * ( -c * v - u*(1-u))), sqrt( (h*v) ^2 + (h*(-c*v - u*(1-u)))^2 ))
	names(df) = c("U", "V", "dU", "dV", "length")

	return(df)

}

c = 3
a = phasePotrait2(1, 1, 0.05, c)
b = phaseSpace(1 ,1 , 0.05, c) 
k = 1
while(k < 5000){

	u0 = runif(1, 0, 1.5)
	v0 = runif(1, -1, 1)

	a = rbind(a, phasePotrait2(u0,v0, 0.05, c))
	#b = rbind(b, phaseSpace(u0, v0, 0.05, c))
	k = k + 1
}


grph2 = ggplot(a, aes(U, V)) + geom_point(alpha = 0.2) + geom_segment(aes(xend = dU, yend = dV, colour = length ), arrow = arrow(length = unit(0.1, "cm"))) + scale_colour_gradient(high="red")
#grph2 = grph2 + geom_line(data = b, aes(x = U, y=V, group = label), na.rm=T)


