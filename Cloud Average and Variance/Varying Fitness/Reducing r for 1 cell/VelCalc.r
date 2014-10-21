rm(list=ls())
data_test = read.csv("Stripped_flat.txt", head = T, sep = "\t")

names(data_test) = c("Time", "Displacement", "Bins", "Mod")

velc = NaN

for(i in c(2:nrow(data_test))){

	vel = (data_test$Displacement[i] -  data_test$Displacement[i-1]) / (data_test$Time[i] -  data_test$Time[i-1])

	velc = c(velc, vel)

}

data_test$Velocity = velc

write.table(data_test, "Stripped_flat.txt", sep = "\t")
rm(list=ls())
