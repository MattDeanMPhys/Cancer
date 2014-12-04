rm(list=ls())

library(ggplot2)
library(grid)
library(tikzDevice)

themeBase = theme_bw(base_size=10) + theme( panel.border = element_rect(colour = "black"), 
		    		panel.grid.major = element_blank(), 
    				panel.grid.minor = element_blank(),
    				axis.ticks.length = unit(0.15, "cm"),
    				axis.ticks.margin = unit(0.15, "cm")
			)


theme_set(themeBase)

x = c(0:9)

rTrap = c(1,1,1, 1.5,1.5,1.5,1,1, 1,1) 
rAntiTrap = c(1,1,1, 0.5,0.5,0.5,1,1, 1,1)

uAntiTrap = c(0.1,0.1,0.1, 0.5,0.5,0.5,0.1,0.1, 0.1,0.1) 
uTrap = c(0.1,0.1,0.1, 0.01,0.01,0.01,0.1,0.1, 0.1,0.1) 

dfrTrap = data.frame(x, rTrap)
dfuTrap = data.frame(x, uTrap)
dfrAntiTrap = data.frame(x, rAntiTrap)
dfuAntiTrap = data.frame(x, uAntiTrap)


rTrapGraph = ggplot(dfrTrap, aes(x, rTrap)) + geom_line() + scale_x_discrete(name = "Cell Type" , limits = c(0:9), expand=c(0,-1) ) + scale_y_continuous(name = "Fitness Value, $r$", limits = c(1,1.51), expand=c(0,0.01), breaks = c(1, 1.5))
rTrapGraph = rTrapGraph +  ggtitle("Fitness Trap")

uTrapGraph = ggplot(dfuTrap, aes(x, uTrap)) + geom_line() + scale_x_discrete(name = "Cell Type" , limits = c(0:9), expand=c(0,-1)) + scale_y_continuous(name = "Mutation Probability, $u$", limits = c(0.01,0.101), expand=c(0,0.01), breaks = c(0.01, 0.1))
uTrapGraph = uTrapGraph + ggtitle("Mutation Trap")

rAntiTrapGraph = ggplot(dfrAntiTrap, aes(x, rAntiTrap)) + geom_line() + scale_x_discrete(name = "Cell Type" , limits = c(0:9), expand=c(0,-1) ) + scale_y_continuous(name = "Fitness Value, $r$", limits = c(0.5,1.01), expand=c(0,0.01), breaks = c(0.5, 1))
rAntiTrapGraph = rAntiTrapGraph + ggtitle("Fitness AntiTrap") 

uAntiTrapGraph = ggplot(dfuAntiTrap, aes(x, uAntiTrap)) + geom_line() +  scale_x_discrete(name = "Cell Type" , limits = c(0:9), expand=c(0,-1) ) + scale_y_continuous(name = "Mutation Probabilty, $u$", limits = c(0.1,0.51), expand=c(0,0.01), breaks = c(0.1, 0.50))
uAntiTrapGraph = uAntiTrapGraph + ggtitle("Mutation AntiTrap") 

tikz("uTrapGraph.tex", width = 3, height = 3)
print(uTrapGraph)
dev.off()

tikz("uAntiTrapGraph.tex", width = 3, height = 3)
print(uAntiTrapGraph)
dev.off()

tikz("rTrapGraph.tex", width = 3, height = 3)
print(rTrapGraph)
dev.off()

tikz("rAntiGraph.tex", width = 3, height = 3)
print(rAntiTrapGraph)
dev.off()



