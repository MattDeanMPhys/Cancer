rm(list=ls())

dataFlat = read.csv("Stripped_flat.txt", head = T, sep = "\t")
data_r0 = read.csv("Stripped_r0.txt", head = T, sep = "\t")
data_r1 = read.csv("Stripped_r1.txt", head = T, sep = "\t")
data_r2 = read.csv("Stripped_r2.txt", head = T, sep = "\t")
data_r3 = read.csv("Stripped_r3.txt", head = T, sep = "\t")
data_r4 = read.csv("Stripped_r4.txt", head = T, sep = "\t")
data_r5 = read.csv("Stripped_r5.txt", head = T, sep = "\t")
data_r6 = read.csv("Stripped_r6.txt", head = T, sep = "\t")
data_r7 = read.csv("Stripped_r7.txt", head = T, sep = "\t")
data_r8 = read.csv("Stripped_r8.txt", head = T, sep = "\t")

dataFlat[1,5] = 0
data_r0[1,5] = 0
data_r1[1,5] = 0
data_r2[1,5] = 0
data_r3[1,5] = 0
data_r4[1,5] = 0
data_r5[1,5] = 0
data_r6[1,5] = 0
data_r7[1,5] = 0
data_r8[1,5] = 0



data_low = rbind(dataFlat, data_r0, data_r1, data_r2)
data_mid = rbind(dataFlat, data_r3, data_r4, data_r5)
data_high = rbind(dataFlat, data_r6, data_r7, data_r8)

#dColours = c("black", "red", "green",  "green",  "green",  "green",  "green",  "green",  "green", "green") 

#names(dColours) = ["flat", "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8"]

lowGraph_dis = ggplot(data_low, aes(Time, Displacement,colour = Mod)) + geom_line() 
lowGraph_vel = ggplot(data_low, aes(Time, Velocity, colour = Mod)) + geom_line()
lowGraph_vel_smooth =  ggplot(data_low, aes(Time, Velocity, colour = Mod)) + geom_smooth(se = F)

midGraph_dis = ggplot(data_mid, aes(Time, Displacement, colour = Mod)) + geom_line()
midGraph_vel = ggplot(data_mid, aes(Time, Velocity, colour = Mod)) + geom_line()
midGraph_vel_smooth =  ggplot(data_mid, aes(Time, Velocity, colour = Mod)) + geom_smooth(se = F)

highGraph_dis = ggplot(data_high, aes(Time, Displacement, colour = Mod)) + geom_line()
highGraph_vel = ggplot(data_high, aes(Time, Velocity, colour = Mod)) + geom_line()
highGraph_vel_smooth =  ggplot(data_high, aes(Time, Velocity, colour = Mod)) + geom_smooth(se = F)

combo = arrangeGrob(lowGraph_dis, midGraph_dis, highGraph_dis,
			 lowGraph_vel, midGraph_vel, highGraph_vel,
				lowGraph_vel_smooth, midGraph_vel_smooth, highGraph_vel_smooth, nrow = 3)

lowCombo = arrangeGrob(lowGraph_dis, lowGraph_vel, lowGraph_vel_smooth, main = textGrob("Reducing the fitness to 0.5 for specified cell", vjust = 1))
midCombo = arrangeGrob(midGraph_dis, midGraph_vel, midGraph_vel_smooth, main = textGrob("Reducing the fitness to 0.5 for specified cell", vjust = 1))

highCombo = arrangeGrob(highGraph_dis, highGraph_vel, highGraph_vel_smooth, main = textGrob("Reducing the fitness to 0.5 for specified cell", vjust = 1))


ggsave(file="lowReduceR.pdf", lowCombo)
ggsave(file="midReduceR.pdf", midCombo)
ggsave(file="highReduceR.pdf", highCombo)

