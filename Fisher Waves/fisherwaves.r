rm(list=ls())

data = read.csv("mesh.txt", sep = "\t", head = F)

i = 1

while(i < nrow(data)){

	plot(unlist(data[i,]), type="l")

	i = i + 1 

}
