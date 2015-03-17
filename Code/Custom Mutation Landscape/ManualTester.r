rm(list=ls())

paramsName = grep("(Parameters)", list.files(), value = T)
statsName = grep("(Statistic)", list.files(), value = T)
popsName = grep("(Populations)", list.files(), value=T)


paramsData = read.csv(paramsName, sep = "\t", head = F)
statsData = read.csv(statsName, sep = "\t", head =T)
popsData = read.csv(popsName, sep = "\t", head = T)

par(mfrow=c(2,1))
plot(statsData$Time, statsData$Displacement, type = "l")
plot(statsData$Time, statsData$Variance, type = "l")

