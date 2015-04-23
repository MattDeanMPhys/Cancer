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
#while(k < 1000){

#	u0 = runif(1, -1, 1.5)
#	v0 = runif(1, -1, 1)

#	a = rbind(a, phasePotrait2(u0,v0, 0.05, c))
#	b = rbind(b, phasePotrait2(u0, v0, 0.05, v))
#	k = k + 1
#}

df = phaseSpace(1, 1, 0.1, 1)
df2 = phaseSpace(1, 1, 0.1, 3)

dom = seq(-2, 2, by = 0.25)
ind1 = 1 
ind2 = 1 
while( ind1 < length(dom) ){

	ind2 = 1 
	while( ind2 < length(dom) ){

		a = rbind(a, phasePotrait2(dom[ind1], dom[ind2], 0.1, c))
		b = rbind(b, phasePotrait2(dom[ind1], dom[ind2], 0.1, v))

		df = rbind(df, phaseSpace(dom[ind1], dom[ind2], 0.02, 1))		
		df2 = rbind(df2, phaseSpace(dom[ind1], dom[ind2], 0.02, 3))		

		ind2 = ind2 + 1 
	}
	
	ind1 = ind1 + 1 
}


graph = ggplot(df, aes(U, V, group=label))  + geom_line() + scale_x_continuous(limits = c(-2,2), expand=c(0,0)) +  scale_y_continuous(limits = c(-2,2), expand=c(0,0)) + ggtitle("$v=1$")
graph = graph + theme_bw() + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + geom_point( x=0 , y = 0, colour = "red" ) + geom_point(x = 1, y= 0, colour = "red")

graph2 = ggplot(df2, aes(U, V, group=label)) + geom_line()+ scale_x_continuous(limits = c(-2,2), expand=c(0,0)) +  scale_y_continuous(limits = c(-2,2), expand=c(0,0)) + ggtitle("$v=3$")
graph2 = graph2 + theme_bw() + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph2 = graph2 + geom_point( x=0 , y = 0, colour = "red" ) + geom_point(x = 1, y= 0, colour = "red")

grph2 = ggplot(a, aes(U, V)) + geom_point(alpha = 0.2, size = 0.1) + geom_segment(aes(xend = dU, yend = dV  ), arrow = arrow(length = unit(0.1, "cm"))) + ggtitle("$v=3$") + theme_bw() + scale_x_continuous(expand=c(0,0))
grph2 = grph2 + geom_point(x=0, y=0, colour = "red") + geom_point(x=1, y = 0, colour = "red") + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
grph2 = grph2 + scale_y_continuous(expand = c(0,0))


grph3 = ggplot(b, aes(U, V)) + geom_point(alpha = 0.2, size = 0.1) + geom_segment(aes(xend = dU, yend = dV  ), arrow = arrow(length = unit(0.1, "cm"))) + ggtitle("$v=1$") + theme_bw() + scale_x_continuous(expand=c(0,0))
grph3 = grph3 + geom_point(x=0, y=0, colour = "red") + geom_point(x=1, y = 0, colour = "red") + theme( panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
grph3 = grph3 + scale_y_continuous(expand=c(0,0))


#tikz(file = "phasePortrait1.tex", width = 3, height = 3)
#print(grph3)
#dev.off()
#tikz(file = "phasePortrait3.tex", width = 3, height = 3)
#print(grph2)
#dev.off()

#tikz(file = "fisherStabilityLinesSpiral.tex", width = 3, height = 3)
#print(graph)
#dev.off()
#
#tikz(file = "fisherStabilityLinesStable.tex", width = 3, height = 3)
#print(graph2)
#dev.off()
#
#tikz(file = "fisherStabilityPointsStable.tex", width = 3, height = 3)
#print(grph2)
#dev.off()
#
#tikz(file = "fisherStabilityPointsSpiral.tex", width = 3, height = 3)
#print(grph3)
#dev.off()
#



