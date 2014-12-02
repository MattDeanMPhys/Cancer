library(ggplot2)
source("gausssiansolution.r")

x = seq(1,100, 0.01)
T = 350 
u = 0.1
x0 = 0

deltaX = 1.0
deltaX_MAX = 4


y1 = gaussol_v2(x, T, deltaX,u,  x0)
df = data.frame(x, y1, rep(1, length(x))) 
names(df) = c("Mutation", "Pop", "Delta")


while(deltaX < deltaX_MAX){

	y1 = gaussol_v2(x, T, deltaX,u, x0)
	new_df = data.frame(x, y1, rep.int(deltaX, length(x))) 

	names(new_df) = c("Mutation", "Pop", "Delta")
	df = rbind(df, new_df)

	deltaX = deltaX + 0.5 
	#x0 = x0 -  4.0
}




grph = ggplot(df, aes(Mutation, Pop, colour=as.factor(Delta))) + geom_line() + theme_bw()
grph = grph + ggtitle("Fourier Solution vs Varying Delta X ") + xlab("Mutation Number") + ylab("Concentration") +scale_colour_discrete("Delta X") 
