rm(list=ls())

data = read.csv("336252458406531_Populations.txt", head = F, sep = "\t")
normVal = data$V2[1]

i = 2
while(i < nrow(data)){

	dataSnap = data[i, 2:(ncol(data) - 1)]

	dataSnap = dataSnap / normVal


	if( dataSnap[ncol(dataSnap)] != 0){

		break
	}

#	dataSnap = log(dataSnap)

	plot(unlist(dataSnap))

	i = i + 1
}


