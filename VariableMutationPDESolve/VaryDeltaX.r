rm(list=ls())

simData = read.csv("1790599216416588_Populations.txt", sep = "\t", head = F)

testPDEData = read.csv("mesh0.02_deltaX.txt", sep = "\t", head = F)
testPDEData2 = read.csv("mesh0.2_deltaX.txt", sep = "\t", head = F)
testPDEData3 = read.csv("mesh0.015_deltaX.txt", sep = "\t", head = F)
testPDEData4 = read.csv("mesh0.1_deltaX.txt", sep = "\t", head = F)

quartz()
plot(simData$V10, type = "l")
matplot(testPDEData$V9*1000, type = "l", col = "red", add = T)
#matplot(testPDEData2$V9*1000, type = "l", col = "blue", add =T)
matplot(testPDEData3$V9*1000, type = "l", col = "blue", add =T)
matplot(testPDEData4$V9*1000, type = "l", col = "green", add =T)

