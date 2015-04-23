rm(list=ls())
library(ggplot2)
library(tikzDevice)


phaseSpace_short <- function(u0, v0, h, c){
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
phaseSpace_long <- function(u0, v0, h, c){
	u = c(u0)
	v = c(v0)

	i = 1
	while( i < 27500){

		u = c(u, u[i] + h *v[i])
		v = c(v, v[i] + h*(-c*v[i] - u[i] * (1 - u[i] )))


		i = i + 1
	}

	label = paste( "(" , u0 , "," , v0 , ")" )

	frame = data.frame(u,v, rep.int(label, length(u)))
	names(frame) = c("U", "V", "label")
	return(frame)

}

df = phaseSpace_long(-0.5, 0.5, 0.1, 1)
df2 = phaseSpace_long(1, 1, 0.1, 3)

#dom = seq(-2, 2, by = 0.50)
#ind1 = 100000 
#ind2 = 1 
#while( ind1 < length(dom) ){
#
#	ind2 = 1 
#	while( ind2 < length(dom) ){
#
#
#		df = rbind(df, phaseSpace_short(dom[ind1], dom[ind2], 0.02, 1))		
#		df2 = rbind(df2, phaseSpace_short(dom[ind1], dom[ind2], 0.02, 3))		
#
#		ind2 = ind2 + 1 
#	}
#	
#	ind1 = ind1 + 1 
#}

spiralGraph = ggplot(df, aes(U, V)) + geom_line(alpha = 0.4)
stableGraph = ggplot(df2, aes(U, V)) + geom_line()

print(spiralGraph)


