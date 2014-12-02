library(ggplot2)
rm(list=ls())



data = read.csv("160641483882148_Populations.txt", sep = "\t", head= F )

time = unlist(data$V1)

data = data[-1]
data = data[-ncol(data)]

i = 10

	x = c(0:9)
	y = unlist(data[i, ])
	
	data = data.frame(x,y)

	graph = ggplot(data, aes(x, y)) + geom_line()
