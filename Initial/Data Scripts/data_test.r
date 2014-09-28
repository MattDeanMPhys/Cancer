rm(list=ls())

population = read.csv("MattTest.txt", header = F)

names(population) = c("Zero", "One", "Two")

#plot(c(1:566), population$Zero[1:566], type="l")
#matplot(c(1:566), population$One[1:566], type="l",col="green", add=T)
#matplot(c(1:566), population$Two[1:566], type="l", col="red", add=T)
#dev.new()
#for (i in c(1:nrow(population))) {
#
#	barplot(c(population[i,1], population[i,2],population[i,3]), ylim = c(0,10))
#}
population$TimeStep = c(1:nrow(population))

sat = which(population$Two == 10)[1]

ts = rep(c(1:sat),3)
pop = c(population$Zero[1:sat],population$One[1:sat],population$Two[1:sat])
mutations = c(rep("Zero",sat), rep("One", sat), rep("Two", sat))
df = data.frame(ts, pop,mutations)


grph = ggplot(df, aes(x=ts, y=pop, colour=mutations, group=mutations))+geom_line()+theme(axis.title.x=element_blank())+ylab("Population")

grph = grph + scale_y_continuous(breaks=NULL)
grph = grph + scale_x_continuous(breaks=NULL)

ggsave(file="InitialDemoGraph280914.png")

