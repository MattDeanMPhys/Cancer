rm(list=ls())


files = list.files()

meshes = grep("hTEST",files, value = T)

i = 1


data = read.csv(meshes[i], sep ="\t", head = F)
data2= read.csv(meshes[i+1], sep ="\t", head = F)
data3= read.csv(meshes[i+2], sep ="\t", head = F)
data4= read.csv(meshes[i+3], sep ="\t", head = F)
data5= read.csv(meshes[i+4], sep ="\t", head = F)
data6= read.csv(meshes[i+5], sep ="\t", head = F)
data7= read.csv(meshes[i+6], sep ="\t", head = F)
data8= read.csv(meshes[i+7], sep ="\t", head = F)
data9= read.csv(meshes[i+8], sep ="\t", head = F)

simData = read.csv("160641483882148_Populations.txt", sep = "\t", head = F)

j=30
#while(j < 1000){

	plot(seq(0,1,length.out=length(unlist(data[j,]))), unlist(data[j,]), type="l", ylim=c(0,1))
	matplot(seq(0,1,length.out=length(unlist(data2[j,]))), unlist(data2[j,]), type="l", add=T, col = "blue")
	matplot(seq(0,1,length.out=length(unlist(data3[j,]))), unlist(data3[j,]), type="l", add=T, col = "red")
	matplot(seq(0,1,length.out=length(unlist(data4[j,]))), unlist(data4[j,]), type="l", add=T, col = "blue")
	matplot(seq(0,1,length.out=length(unlist(data5[j,]))), unlist(data5[j,]), type="l", add=T, col = "red")
	matplot(seq(0,1,length.out=length(unlist(data6[j,]))), unlist(data6[j,]), type="l", add=T, col = "blue")
	matplot(seq(0,1,length.out=length(unlist(data7[j,]))), unlist(data7[j,]), type="l", add=T, col = "red")
	matplot(seq(0,1,length.out=length(unlist(data8[j,]))), unlist(data8[j,]), type="l", add=T, col = "blue")
	matplot(seq(0,1,length.out=length(unlist(data9[j,]))), unlist(data9[j,]), type="l", add=T, col = "red")

	matplot(seq(0,1,length.out = (10)), unlist(simData[j, 2:11])/1000, type = "l", add=T, col = "green")	

	j = j + 1
#}


