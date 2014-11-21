rm(list=ls())

a = read.csv("pdesolve.txt", head = F, sep= "\t")

i = 1
while(i < 10000){

	plot( unlist(a[i,]), type="l")

	i = i + 1 
}

