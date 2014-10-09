rm(list=ls())

names = c("a", "b", "c", "d", "e")

keep = c("V1", "V2", "V3")

for( i in c(1:5)){

assign(paste("a",i,sep=""), read.csv(paste(i, "txt", sep="."), sep = "\t", header = F))


}


