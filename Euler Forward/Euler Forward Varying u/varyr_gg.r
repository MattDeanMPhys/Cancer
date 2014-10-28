library(ggplot2)
library(grid)
library(gridExtra)

dat = read.csv("U_99_mutationrate_0-01_trap_between_10_vel.txt", header = F, sep = "\t")


names(dat) = c("Time", "Displacement", "Velocity", "Label")

grph = ggplot(dat, aes(Time, Displacement, colour=Label)) +geom_line()
grphvel =ggplot(dat, aes(Time, Velocity, colour=Label)) +geom_line() 
grphcombo = arrangeGrob(grph, grphvel)