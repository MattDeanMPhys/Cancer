rm(list=ls())
library(ggplot2)
library(grid)

phasePotrait <- function(u0, v0, v, h, a, b, c){

	alpha = (b + v )/c 
	beta = a/c

	df = data.frame(u0, v0, (u0 + h*v0), (v0 + h * ( -alpha * v0 - beta*u0)) )
	names(df) = c("U", "V", "dU", "dV")

	return(df)
}

phasePortrait2 <- function(u0, v0, v, h, a,b,c){

	label = paste( "(" , u0 , "," , v0 , ")" )
	U = c(u0)
	V = c(v0)
	alpha = (b + v )/c 
	beta = a/c

	i = 1 
	I = 500
	while(i < I){
	
		U = c(U, U[i] + h*V[i])
		V = c(V, V[i] + h*(-alpha*V[i] - beta*U[i]))
		i = i + 1 
	}

	df = data.frame(U, V, rep.int(label, 10))
	names(df) = c("U", "V", "label")
	return(df)
}

v = 10
h = 0.01
a = -1.0 
b = 1 
c = 1

lines = phasePortrait2(0,0, v, h, a, b, c)
point = phasePotrait(0,0, v, h, a, b, c)

i = 1 
for(i in c(1:10)){
	for(j in c(1:10)){

		#u0 = runif(1, -1, 1)
		#v0 = runif(1, -1, 1)

		u0 = -1 + i*0.2
		v0 = -1 + j*0.2

		lines = rbind(lines, phasePortrait2(u0, v0, v, h, a, b, c))
		point = rbind(point, phasePotrait(u0,v0, v, h, a, b, c))

	}
}
pointGraph = ggplot(point, aes(U, V)) + geom_point(alpha = 0.2) + geom_segment(aes(xend = dU, yend = dV  ), arrow = arrow(length = unit(0.1, "cm"))) 
flowGraph = ggplot(lines, aes(U, V, group = label )) + geom_line(alpha = 0.5 )
print(flowGraph)






#i = 1 

#v = 1 
#h = 0.05
#a = phasePotrait(0,0,v,h, 0, 1, 1)

#while(i < 1500){
	
#	u0 = runif(1, -1, 1)
#	v0 = runif(1, -1, 1)

#	a = rbind(a, phasePotrait(u0, v0, v, h, 0, 1, 1))

#	i = i + 1
#}
	
#grph = ggplot(a, aes(U, V)) + geom_point(alpha = 0.2) + geom_segment(aes(xend = dU, yend = dV  ), arrow = arrow(length = unit(0.1, "cm"))) + ggtitle("$v=3$") + theme_bw() + scale_x_continuous(expand=c(0,0))
