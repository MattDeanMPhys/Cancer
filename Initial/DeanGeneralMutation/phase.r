rm(list=ls())

data = read.csv("GenData2.txt", header=F)

plot(c(1:nrow(data)),data$V1, type="l", col="green")
matplot(c(1:nrow(data)),data$V2, type="l", add=T, col="blue")
matplot(c(1:nrow(data)),data$V3, type="l", add=T, col="red")

delta = 0 
for (i in c(2:nrow(data))){

	delta =c(delta, (data$V1[i] - data$V1[i-1]))
}
