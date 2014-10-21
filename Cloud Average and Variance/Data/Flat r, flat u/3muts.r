library(ggplot2)
library(gridExtra)

data3 = read.csv("Statistic_Output_3Muts.txt", head = F, sep = "\t")
data10 = read.csv("Statistic_Output_10Muts.txt", head = F, sep = "\t")


names(data3) = c("Time", "Average", "Bins")
names(data10) = c("Time", "Average", "Bins")

a = ggplot(data3, aes(Time, Average) ) + geom_line() + ggtitle("3 Mutations, 10,000 Cells: Cell Type")
b = ggplot(data3, aes(Time, Bins) ) + geom_line() + ggtitle("3 Mutations, 10,000 Cells: Number of Mutations")
c = ggplot(data10, aes(Time, Average) ) + geom_line() + ggtitle("10 Mutations, 10,000 Cells: Cell Type")
d = ggplot(data10, aes(Time, Bins) ) + geom_line() + ggtitle("10 Mutations, 10,000 Cells: Number of Mutations")

#grid.arrange(a,b, col = 2)

f = arrangeGrob(a,c,b, d)

ggsave(file = "AveragesandBins.pdf", f)
