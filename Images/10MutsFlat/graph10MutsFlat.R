library(ggplot2)
library(tikzDevice)
library(grid)
rm(list=ls())



data = read.csv("160641483882148_Populations.txt", sep = "\t", head= F )

time = unlist(data$V1)

data = data[-1]
data = data[-ncol(data)]

i = 90

	x = c(0:9)
	y = unlist(data[i, ])
	
	data = data.frame(x,y)

	graph = ggplot(data, aes(x, y)) + geom_line() + geom_point()

	graph = graph + theme_bw(base_size=10) + theme(  panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
	graph = graph + theme(axis.ticks.length = unit(0.15, "cm"),  axis.ticks.margin = unit(0.10, "cm"))	
	graph = graph + theme(axis.title.y = element_text(vjust = 1.0))
	graph = graph + theme(legend.position="none")
	graph = graph + scale_x_discrete("Cell Type", c(0:9))
	graph = graph + scale_y_continuous(limits = c(0,1000), "Population Number")
	graph = graph + ggtitle("10 Cell Types, 9 Mutations" )	

	graph = graph + annotate("text", x  = 7, y = 900, label = paste("$t = $ ", time[i], sep="" ) ) 

	fileName = paste("10MutsFLAT", time[i], ".tex", sep="")

	tikz(file=fileName, width = 3, height = 3)
	print(graph)
	dev.off()

