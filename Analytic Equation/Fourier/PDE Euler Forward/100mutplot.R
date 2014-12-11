library(ggplot2)
library(tikzDevice)
library(grid)
rm(list=ls())

dat = read.csv("100mut.txt", sep = "\t", head = T)

	graph = ggplot(dat, aes(Time, Variance)) + geom_line()
	graph = graph + theme_bw(base_size=10) + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
	graph = graph + theme(axis.ticks.length = unit(0.15, "cm"),  axis.ticks.margin = unit(0.15, "cm")) 
	graph = graph + theme(axis.title.y = element_text(vjust = 1.0))
	graph = graph + scale_x_continuous("Time", expand=c(0,0))
	graph = graph + scale_y_continuous("Variance", expand=c(0,0))
	graph = graph + ggtitle("100 Mutation Cloud Variance")	

	fileName = "100mut_var.tex"
	tikz(file=fileName, width = 3, height = 3)
	print(graph)
	dev.off()


