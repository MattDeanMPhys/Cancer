rm(list=ls())
library(ggplot2)
library(grid)
library(gridExtra)
library(tikzDevice)

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
v = 1
a = phasePotrait2(1, 1, 0.05, c)
b = phasePotrait2(1 ,1 , 0.05, v) 
k = 1
while(k < 1000){

	u0 = runif(1, -1, 1.5)
	v0 = runif(1, -1, 1)

	a = rbind(a, phasePotrait2(u0,v0, 0.05, c))
	b = rbind(b, phasePotrait2(u0, v0, 0.05, v))
	k = k + 1
}

grph2 = ggplot(a, aes(U, V)) + geom_point(alpha = 0.2) + geom_segment(aes(xend = dU, yend = dV  ), arrow = arrow(length = unit(0.1, "cm"))) + ggtitle("$v=3$") + theme_bw() + scale_x_continuous(expand=c(0,0))
grph3 = ggplot(b, aes(U, V)) + geom_point(alpha = 0.2) + geom_segment(aes(xend = dU, yend = dV  ), arrow = arrow(length = unit(0.1, "cm"))) + ggtitle("$v=1$") + theme_bw() + scale_x_continuous(expand=c(0,0))

tikz(file = "phasePortrait1.tex", width = 3, height = 3)
print(grph3)
dev.off()

tikz(file = "phasePortrait3.tex", width = 3, height = 3)
print(grph2)
dev.off()

