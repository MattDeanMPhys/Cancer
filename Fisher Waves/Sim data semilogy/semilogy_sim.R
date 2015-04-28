rm(list=ls())
library(ggplot2)
library(tikzDevice)


FixTime_1 =  read.csv("3712388518298864_FixationTimes.txt", head = F, sep = "\t")
FixTime_2 = read.csv("3712396145837594_FixationTimes.txt", head = F, sep = "\t")

negStats = read.csv("3712388518298864_StatisticOutput.txt", head = T, sep = "\t") 
posStats = read.csv("3712396145837594_StatisticOutput.txt", head = T, sep = "\t")

negPop = read.csv("3712388518298864_Populations.txt", head = F, sep = "\t") 
posPop = read.csv("3712396145837594_Populations.txt", head = F, sep = "\t")

posPop = posPop[-1]
posPop = posPop[-ncol(posPop)]

negPop = negPop[-1]
negPop = negPop[-ncol(negPop)]

###################################################
# For a time at 1/8 total runtime 
###################################################

# test2 = log(unlist(posPop[nrow(posPop)/8,]))
# Frame2 = data.frame(c(1:ncol(posPop)), test2, rep.int("t=2", ncol(posPop)))
# names(Frame2) = c("x", "Population", "Time")

# linstart = 48
# linend = 60
# linsec = log(unlist(posPop[nrow(posPop)/8,(linstart):(linend)]))
# xt = seq(linstart,linend,length.out=(length(linsec)))
# res=lm(linsec~xt)

# dFrame = rbind(Frame2)

# graph = ggplot(dFrame, aes(x, Population, group=Time))  + geom_line() + theme_bw() + theme(panel.border = element_rect(colour = 
# 	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
# graph = graph + theme(legend.position = "none") + scale_x_continuous("Mutation space", expand=c(0,0), limits=c(48,70)) + scale_y_continuous("Population number", expand=c(0,0))
# graph = graph + ggtitle("Sim data exponential test")
# graph = graph + geom_abline(intercept = 21.5148, slope = -0.3856, aes(color='red'))
# # tikz(file = "FisherWavesFKKP_log.tex", width = 3, height = 3)
# print(graph)
# # dev.off()

###################################################
#For a time at 1/4 total runtime 
###################################################

linstart = 80
linend = 96

test2 = log(unlist(posPop[nrow(posPop)/4,]/posPop[1,1]))
Frame2 = data.frame(c(1:ncol(posPop)), test2, rep.int("t=2", ncol(posPop)))
names(Frame2) = c("x", "Population", "Time")

linsec = log(unlist(posPop[nrow(posPop)/4,(linstart):(linend)])/posPop[1,1])
xt = seq(linstart,linend,length.out=(length(linsec)))
res=lm(linsec~xt)

dFrame = rbind(Frame2)

graph = ggplot(dFrame, aes(x, Population, group=Time))  + geom_point() + theme_bw() + theme(panel.border = element_rect(colour = 
	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("Mutation Number", expand=c(0,0), limits=c(linstart,linend)) + scale_y_continuous("Log Concentration", expand=c(0,0), limits=c(-7,-3))
graph = graph + ggtitle("Test")
graph = graph + geom_abline(intercept = res[[1]][[1]], slope = res[[1]][[2]], aes(color='red'))
tikz(file = "exp_simdata_pos.tex", width = 3, height = 3)
print(graph)
dev.off()

###################################################
# For a time at 1/10 total runtime 
###################################################
#NArm = t

linstart = 60
linend = 80
t=0.1 #as fraction of total time

test2 = log(unlist(negPop[nrow(negPop)*t,]/negPop[1,1]))
Frame2 = data.frame(c(1:ncol(negPop)), test2, rep.int("t=2", ncol(negPop)))
names(Frame2) = c("x", "Population", "Time")

linsec = log(unlist(negPop[nrow(negPop)*t,(linstart):(linend)])/negPop[1,1])
xt = seq(linstart,linend,length.out=(length(linsec)))
res=lm(linsec~xt)

dFrame = rbind(Frame2)

graph = ggplot(dFrame, aes(x, Population, group=Time))  + geom_point() + theme_bw() + theme(panel.border = element_rect(colour = 
	"black"), panel.grid.major = element_blank(), panel.grid.minor = element_blank())
graph = graph + theme(legend.position = "none") + scale_x_continuous("Mutation Number", expand=c(0,0), limits=c(linstart,linend)) + scale_y_continuous("Log Concentration", expand=c(0,0), limits=c(-7,-3))
graph = graph + ggtitle("Test")
graph = graph + geom_abline(intercept = res[[1]][[1]], slope = res[[1]][[2]], aes(color='red'))
tikz(file = "exp_simdata_neg.tex", width = 3, height = 3)
print(graph)
dev.off()
