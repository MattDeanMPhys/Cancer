rm(list=ls())

a = read.csv("GenData2.txt", header=F)

for(i in c(1:nrow(a))) {

	barplot(c(a[i,1],a[i,2],a[i,3]), ylim=c(0,10))
}


