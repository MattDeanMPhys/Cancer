rm(list=ls())


fish = read.csv("meshDean.txt", head = F, sep = "\t")


plot(unlist(fish[1,]), type = "l")
matplot(unlist(fish[nrow(fish)/4, ]), type = "l", col = "red", add=T)
matplot(unlist(fish[nrow(fish)/2, ]), type = "l", col = "red", add=T)
matplot(unlist(fish[3*nrow(fish)/4, ]), type = "l", col = "red", add=T)
matplot(unlist(fish[nrow(fish), ]), type = "l", col = "blue", add=T)
