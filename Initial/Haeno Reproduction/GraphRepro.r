rm(list = ls())

vals1 = read.csv("GraphC_01.txt", header = F, sep="\t")
vals2 = read.csv("GraphC_001.txt", header = F, sep="\t")
vals3 = read.csv("GraphC_0001.txt", header = F, sep="\t")

r1 = c(vals1$V1, vals2$V1,vals3$V1)
prob = c(vals1$V2, vals2$V2,vals3$V2)
u1 = c(rep.int("0.1", nrow(vals1)), rep.int("0.01", nrow(vals1)),rep.int("0.001", nrow(vals1)))

df = data.frame(r1, prob, u1)

a = ggplot(df, aes(x=r1, y=prob, colour=u1, group = u1))+geom_line()
a = a + ylab("Fixation probability of type-2 cells before time t") + xlab("Fitness of type-1 cells, r1")
#a = a + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
#a = a + scale_y_continuous(expand=c(0,0), limits = c(0,0.40))
#a = a + scale_x_continuous(expand = c(0,0), limits = c(0, 3.0))
#a = a + theme(plot.margin = unit(c(0,0,0,0), "mm"))
#a = a + annotate("text", x= 0.75, y = 0.35, label = "r0=1, r2=2, u2=0.001")

ggsave(file = "GraphC021014.png")
