rm(list=ls())

a = read.csv("pdesolve.txt", head = F, sep= "\t")

i = 1
while(i < 100000){

	plot( unlist(a[i,]), type="l", ylim=c(0,1))

	i = i + 100 
}

