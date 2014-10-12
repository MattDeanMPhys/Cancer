rm(list=ls())

data = read.csv("Output.txt", sep = "\t", head = F)

number_cells = data$V1[1]

data = data/number_cells 

weights = c(1:100)

need to use weighted mean, with apply and function(x) mean.weighted(x, weights....)
something like that at least. 
