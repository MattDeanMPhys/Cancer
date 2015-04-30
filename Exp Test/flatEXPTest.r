rm(list=ls())

data = read.csv("3761195744918538_Populations.txt", sep = "\t", head = F)
normVal = data$V2[1]
