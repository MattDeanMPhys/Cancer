dat=read.csv(paste("U_99_mutationrate_",0,".txt", sep=""))
plot(dat[1:nrow(dat), ncol(dat)], dat[1:nrow(dat), 1], type='l')
for(i in 1:10) { 
	if(i*10 == 100) { 
		dat=read.csv(paste("U_99_mutationrate_",i*10, ".txt",sep=""))
		matplot(dat[1:nrow(dat), ncol(dat)], dat[1:nrow(dat), 1], type='l', add=T, col='blue')
	}
	else {
		dat=read.csv(paste("U_99_mutationrate_",i*10, ".txt",sep=""))
		matplot(dat[1:nrow(dat), ncol(dat)], dat[1:nrow(dat), 1], type='l', add=T)
		
	}
}
dat=read.csv(paste("U_99",".txt", sep=""))
matplot(dat[1:nrow(dat), ncol(dat)], dat[1:nrow(dat), 1], type='l', add=T, col='red')


