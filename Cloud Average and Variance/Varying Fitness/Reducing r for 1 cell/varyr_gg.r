library(ggplot2)


data = read.csv("new_r0r8stripped.txt", head = F, sep = "\t")


names(data) = c("Time", "Average", "Bins", "r")

grph = ggplot(data, aes(Time, Average, colour=r)) +geom_line()
