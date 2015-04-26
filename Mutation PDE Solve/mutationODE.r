rm(list=ls())
library(ggplot2)
library(tikzDevice)


mutateSolver <- function(C_in, initial_in){

	C = C_in
	deltaX = 1/100
	h = 0.001

	u = c(0:(1/deltaX)) * 0

	a = ( deltaX/(2*h^2) + 1/h )^(-1)




	u[1] = initial_in
	u[2] = u[1] * a * ( deltaX/h^2 + C + 1/h )

	i = 2
	while(i < length(u)){


		u[i+1] = u[i] * a *  ( deltaX/h^2 + C + 1/h ) - deltaX/(2*h^2) * u[i-1] * a

		i = i + 1
	}

	if( C_in < 0){
	
		label = "Negative"

	}
	if( C_in > 0){
	
		label = "Positive"

	}


	#label = paste(C_in, initial_in)

	frame = data.frame(c(0:(1/deltaX)), u, rep.int(label, length(u)))
	names(frame) = c("Number", "Probabilty", "Label")

	return(frame)

}


pos = mutateSolver(5, 0.10)
neg = mutateSolver(-5, 0.10)
pos_2 = mutateSolver(1, 0.2)
neg_2 = mutateSolver(-1, 0.2)
pos_3 = mutateSolver(1, 0.3)
neg_3 = mutateSolver(-1, 0.3)
pos_4 = mutateSolver(2, 0.1)
neg_4 = mutateSolver(-2, 0.1)
pos_5 = mutateSolver(2, 0.2)
neg_5 = mutateSolver(-2, 0.2)
pos_6 = mutateSolver(2, 0.3)
neg_6 = mutateSolver(-2, 0.3)




frame = rbind(pos, neg, pos_2, neg_2, pos_3, neg_3, pos_4, neg_4, pos_5, neg_5, pos_6, neg_6)

graph = ggplot(frame, aes(Number, Probabilty, colour = Label) ) + geom_line()

frame2 = rbind(pos, neg)
graph2 = ggplot(frame2, aes(Number, Probabilty, linetype = Label) ) + geom_line() + theme_bw() + theme(panel.border = element_rect(colour = "black"))
graph2 = graph2 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + scale_x_continuous("Mutation Number", expand = c(0,0))
graph2 = graph2 + scale_y_continuous(expand=c(0,0)) + theme(legend.position= c(0.2, 0.85), legend.title=element_blank())



#tikz(file = "mutationRateWaves.tex", width = 3, height = 3)
#print(graph2)
#dev.off()

