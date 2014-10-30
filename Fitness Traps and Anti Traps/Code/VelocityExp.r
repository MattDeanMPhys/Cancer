rm(list=ls())
filename = list.files()[grep("Stat", list.files())]


data = read.csv(filename, sep="\t")

velCal = function(n){

vel = rep(0, nrow(data))

for(i in range(1:nrow(data)-n)){

	vel[i] = (data$Displacement[i+n] - data$Displacement[i]) / (data$Time[i+n] - data$Time[i])


}


plot(data$Time, data$Velocity, type="l")
matplot(data$Time, vel, add= T, col="red", type="l")

}

velCal(10)
