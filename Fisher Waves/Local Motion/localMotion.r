rm(list=ls())
library(ggplot2)

data = read.csv("meshDean.txt", sep = "\t", head = F)



i = 1
disp = 0 

while(i < 5000){
	snap = unlist(data[i,])

	snap[1:which.max(snap)] = 1

	velCalcX = c(which(snap < 0.5)[1],  which(snap < 0.5)[1]-1)
	velCalcY = snap[velCalcX]
	interp = approx(velCalcY, velCalcX, xout = 0.5)
	disp = c(disp, interp$y)

	#plot(snap, type="l")

	i = i + 1 
}

vel = 0 

for(j in c(2:length(disp))){

	vel = c(vel, (disp[j] - disp[j-1])/0.005)
	j = j + 1 



}
vel = vel[-1]
vel = vel[-1]

frame = data.frame(c(1:length(vel)), vel)
names(frame) = c("Time", "Velocity")


graph = ggplot(frame, aes(Time, Velocity)) + geom_line() + theme_bw()

