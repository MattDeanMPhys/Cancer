rm(list=ls())
library(ggplot2)
library(tikzDevice)

FixTime_1 =  read.csv("3767796507356326_FixationTimes.txt", head = F, sep = "\t")
FixTime_2 = read.csv("3767780823707108_FixationTimes.txt", head = F, sep = "\t")
FixTime_3 = read.csv("3767859514631484_FixationTimes.txt", head=F, sep="\t")

negStats = read.csv("3767796507356326_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3767780823707108_StatisticOutput.txt", head = T, sep = "\t")
flatStats = read.csv("3767859514631484_StatisticOutput.txt", head=T, sep="\t")

negPop = read.csv("3767796507356326_Populations.txt", head = F, sep = "\t") 
posPop = read.csv("3767780823707108_Populations.txt", head = F, sep = "\t")
flatPop = read.csv("3767859514631484_Populations.txt", head=F, sep="\t")

time=negPop[,1]

posPop = posPop[-1]
posPop = posPop[-ncol(posPop)]

negPop = negPop[-1]
negPop = negPop[-ncol(negPop)]

flatPop = flatPop[-1]
flatPop = flatPop[-ncol(negPop)]
flatPop = flatPop[-ncol(negPop)]

# Negative mutation

t=1
vector = c(0)
maxt = which(negPop[,ncol(negPop)] > 0 )[[1]]
while(t <= maxt) {
	test2 = log(unlist(negPop[t,]/max(negPop[t,])))
	# test2 = test[!is.infinite(test)]
	linstart = which.max( test2 )[[1]]
	linstart = which(test2[linstart:length(test2)] < log(0.2))[[1]]+linstart-2

	if(is.na(which(is.infinite(test2[linstart:length(test2)]))[1])) {
		linend = length(test2)
	}
	else {
		linend = which(is.infinite(test2[linstart:length(test2)]))[[1]]+linstart-2
	}	

	linsec = log(unlist(negPop[t,(linstart):(linend)])/max(negPop[t,]))
	xt = seq(linstart,linend,length.out=(length(linsec)))
	res=lm(linsec~xt)	

	vector <- c(vector,summary(res)$r.^2)	

	t=t+1
	# print(t)
}

vector = vector[-1]

Frame2 = data.frame(c(1:maxt), vector, rep.int("t=2",maxt))
names(Frame2) = c("Time", "Residual", "Label")

dFrame = rbind(Frame2)

ymin = 0.5 
ymax = 1

# ymin = min(vector)
# ymax = max(vector)

linsec = unlist(vector)
xt = seq(0,maxt,length.out=(length(linsec)))
res=lm(linsec~xt)

graph = ggplot(dFrame, aes(Time, Residual, group=Label))  + geom_line() + geom_smooth(method='lm')+ theme_bw() + theme(panel.border = element_rect(colour = 
	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("Time", expand=c(0,0)) + scale_y_continuous("Residual squared", expand=c(0,0), limits=c(ymin,ymax))
graph = graph + ggtitle("Neg")
# graph = graph + geom_abline(intercept = res[[1]][[1]], slope = res[[1]][[2]], aes(color='red'))
tikz(file = "res_data_neg.tex", width = 3, height = 3)
print(graph)
dev.off()

# Positive mutation

t=1
vector = c(0)
maxt = which(posPop[,ncol(posPop)] > 0 )[[1]]
while(t <= maxt) {
	test2 = log(unlist(posPop[t,]/max(posPop[t,])))
	# test2 = test[!is.infinite(test)]
	linstart = which.max( test2 )[[1]]
	linstart = which(test2[linstart:length(test2)] < log(0.2))[[1]]+linstart-2

	if(is.na(which(is.infinite(test2[linstart:length(test2)]))[1])) {
		linend = length(test2)
	}
	else {
		linend = which(is.infinite(test2[linstart:length(test2)]))[[1]]+linstart-2
	}	

	linsec = log(unlist(posPop[t,(linstart):(linend)])/max(posPop[t,]))
	xt = seq(0,maxt,length.out=(length(linsec)))
	res=lm(linsec~xt)	

	vector <- c(vector,summary(res)$r.^2)	

	t=t+1
	# print(t)
}

vector = vector[-1]

Frame2 = data.frame(c(1:maxt), vector, rep.int("t=2",maxt))
names(Frame2) = c("Time", "Residual", "Label")

dFrame = rbind(Frame2)


ymin = 0.5 
ymax = 1
# ymin = min(vector)
# ymax = max(vector)

linsec = unlist(vector)
xt = seq(0,maxt,length.out=(length(linsec)))
res=lm(linsec~xt)

graph = ggplot(dFrame, aes(Time, Residual, group=Label))  + geom_line() + geom_smooth(method='lm') + theme_bw() + theme(panel.border = element_rect(colour = 
	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("Time", expand=c(0,0)) + scale_y_continuous("Residual squared", expand=c(0,0), limits=c(ymin,ymax))
graph = graph + ggtitle("Pos")
# graph = graph + geom_abline(intercept = res[[1]][[1]], slope = res[[1]][[2]], aes(color='red'))
tikz(file = "res_data_pos.tex", width = 3, height = 3)
print(graph)
dev.off()

# Flat mutation

t=1
vector = c(0)
maxt = which(flatPop[,ncol(flatPop)] > 0 )[[1]]
while(t <= maxt) {
	test2 = log(unlist(flatPop[t,]/max(flatPop[t,])))
	# test2 = test[!is.infinite(test)]
	linstart = which.max( test2 )[[1]]
	linstart = which(test2[linstart:length(test2)] < log(0.2))[[1]]+linstart-2

	if(is.na(which(is.infinite(test2[linstart:length(test2)]))[1])) {
		linend = length(test2)
	}
	else {
		linend = which(is.infinite(test2[linstart:length(test2)]))[[1]]+linstart-2
	}	

	linsec = log(unlist(flatPop[t,(linstart):(linend)])/max(flatPop[t,]))
	xt = seq(linstart,linend,length.out=(length(linsec)))
	res=lm(linsec~xt)	

	vector <- c(vector,summary(res)$r.^2)	

	t=t+1
	# print(t)
}

vector = vector[-1]

Frame2 = data.frame(c(1:maxt), vector, rep.int("t=2",maxt))
names(Frame2) = c("Time", "Residual", "Label")

dFrame = rbind(Frame2)

ymin = min(vector)
ymax = max(vector)

linsec = unlist(vector)
xt = seq(0,maxt,length.out=(length(linsec)))
res=lm(linsec~xt)

graph = ggplot(dFrame, aes(Time, Residual, group=Label)) + geom_line() + geom_smooth(method='lm') + theme_bw() + theme(panel.border = element_rect(colour = 
	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("Time", expand=c(0,0)) + scale_y_continuous("Residual squared", expand=c(0,0), limits=c(0.5,1))
graph = graph + ggtitle("Flat")
# graph = graph + geom_abline(intercept = res[[1]][[1]], slope = res[[1]][[2]], aes(color='red'))
tikz(file = "res_data_flat.tex", width = 3, height = 3)
print(graph)
dev.off()
