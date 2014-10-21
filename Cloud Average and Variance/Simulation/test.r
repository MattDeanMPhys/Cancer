data = read.csv("Statistic_Output.txt", head = F, sep = "\t")

plot(data$V2, type="l")
