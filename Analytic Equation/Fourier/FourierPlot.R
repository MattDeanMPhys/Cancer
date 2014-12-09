library(ggplot2)
library(tikzDevice)
library(grid)
rm(list=ls())

source("FourierSolution.R")


dat = read.csv("Euler_Forward_0-1_1_200_species.bin", sep = "\t", head = F)

time = unlist(dat$V1)

dat = dat[-1]
dat = dat[-ncol(dat)]

i=9500

	#plot(c(0:199), unlist(dat[i,]), type="l", lty=3)
	#matplot(c(0:200), FourierSolution(200, time[i], 0.1, 1), add = T, type = "l")


	xAxis = c(c(0:199), c(0:200))

	analyticConcentrations = FourierSolution(200, time[i], 0.1, 1)
	efConcentrations = unlist(dat[i,])

	#concentrationError = efConcentrations - analyticConcentrations
	#xAxisError = c(0:200)

	#dataError = data.frame(concentrationError, xAxisError)

	#matplot(c(0:200), concentrationError, type="l", add=T)

	concentrations = c(efConcentrations ,analyticConcentrations  )
	
	Label = c( rep.int("EulerForward", 200), rep.int("Analytic", 201))

	data = data.frame(xAxis, concentrations, Label)

	graph = ggplot(data, aes(xAxis, concentrations, shape = Label, colour = Label, group = Label)) + geom_point() + scale_fill_manual(values=c("gray53", "black")) + scale_colour_manual(values=c("gray53", "black"))
	graph = graph + theme_bw(base_size=10) + theme(panel.border = element_rect(colour = "black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) 
	graph = graph + theme(axis.ticks.length = unit(0.15, "cm"),  axis.ticks.margin = unit(0.15, "cm"))	
	graph = graph + theme(axis.title.y = element_text(vjust = 1.0))
	graph = graph + scale_x_continuous("Cell Type")
	graph = graph + scale_y_continuous(limits = c(0,0.045), "Population Number")
	graph = graph + ggtitle("Analytic and Euler")	
	fileName = "analytic_fourier_and_euler.tex"
	tikz(file=fileName, width = 3, height = 3)
	print(graph)
	dev.off()


