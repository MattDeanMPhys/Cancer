rm(list=ls())

mesh = read.csv("meshCos.txt", sep = "\t", head = F)

i = 1
while(i < 101){

	plot(mesh[,i], type = "l", ylim=c(0,1))
	i = i + 1
}
