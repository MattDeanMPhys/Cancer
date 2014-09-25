rm(list=ls())

population = read.csv("data.txt", header = F)

names(population) = c("Zero", "One", "Two")

plot(c(1:566), population$Zero[1:566], type="l")
matplot(c(1:566), population$One[1:566], type="l",col="green", add=T)
matplot(c(1:566), population$Two[1:566], type="l", col="red", add=T)
dev.new()
for (i in c(1:nrow(population))) {

	barplot(c(population[i,1], population[i,2],population[i,3]), ylim = c(0,10))
}
