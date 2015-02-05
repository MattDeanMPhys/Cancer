rm(list=ls())
library(ggplot2)

mesh = read.table("mesh.txt", sep = "\t", head = F)
mut = read.table("mut.txt", sep = "\t", head = F)
mutD = read.table("mutD.txt", sep = "\t", head = F)
mutD2 = read.table("mutD2.txt", sep= "\t", head = F)
f = read.table("f.txt", sep="\t", head = F)

simData = read.csv("1790599216416588_Populations.txt", sep = "\t", head = F)

V1Diff = simData[,2]/1000 - mesh[1:nrow(simData),1]
V2Diff = simData[,3]/1000 - mesh[1:nrow(simData),2]
V3Diff = simData[,4]/1000 - mesh[1:nrow(simData),3]

plot(simData[,2], type="l")
matplot(simData[,3], type="l", add = T)
matplot(simData[,13], type="l", add = T)
matplot(simData[,23], type="l", add = T)
matplot(simData[,33], type="l", add = T)
matplot(simData[,43], type="l", add = T)
matplot(mesh[,42]*1000, type="l", add = T, col = "red")
matplot(mesh[,32]*1000, type="l", add = T, col = "red")
matplot(mesh[,22]*1000, type="l", add = T, col = "red")
matplot(mesh[,12]*1000, type="l", add = T, col = "red")
matplot(mesh[,2]*1000, type="l", add = T, col = "red")
matplot(mesh[,1]*1000, type="l", add = T, col = "red")





errors = 0 
i =1 
while( i < 50){

	errors = c(errors, simData[,i+1]/1000 - mesh[1:nrow(simData), i])
	
	i = i + 1
}
