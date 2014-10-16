#Varying one r to 0.5.
#Flat u at 0.1
#10 mutations
#10000 cells
#25 iterations

rm(list=ls())

for(i in c(1:5)){

	assign(paste("r", i-1, sep=""), read.csv( paste("Statistic_Output_r",i-1, ".txt", sep=""), head = F, sep = "\t"))
	
	time = paste("r", i-1, sep="")[,2]
	average = paste("r", i-1, sep="")$V2
	label = rep.int(paste("r", i-1, sep=""), nrow(time))
	
}

plot(r0$V1, r0$V2, type="l")

for(j in c(1:4)){

	matplot( paste("r", j, "$V1", sep=""),  paste("r", j, "$V2", sep=""), type = "l", add=T)

}
