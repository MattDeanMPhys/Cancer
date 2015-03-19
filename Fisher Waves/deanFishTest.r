rm(list=ls())


fish = read.csv("meshDean.txt", head = F, sep = "\t")

par(mfrow = c(3,1))

plot(unlist(fish[1,]), type = "l")
matplot(unlist(fish[nrow(fish)/4, ]), pch=3, col = "red", add=T)
matplot(unlist(fish[nrow(fish)/2, ]), pch = 3, col = "red", add=T)
matplot(unlist(fish[3*nrow(fish)/4, ]), pch = 3, col = "red", add=T)
matplot(unlist(fish[nrow(fish), ]), pch=3, col = "blue", add=T)

plot(fish[,1],type="l", ylim = c(0,1))
matplot(fish[, ncol(fish)/4], type = "l", add=T) 
matplot(fish[, ncol(fish)/2], type = "l", add=T) 
matplot(fish[, 3*ncol(fish)/4], type = "l", add=T) 
matplot(fish[, ncol(fish)], type = "l", add=T) 


i = 2
vel = 0  

while( i < length(fish[,ncol(fish)/4])){

	disp = fish[,ncol(fish)/4]

	vel = c(vel, (disp[i] - disp[i-1])/0.005)

	i = i + 1 

}

plot(vel, type = "l")
