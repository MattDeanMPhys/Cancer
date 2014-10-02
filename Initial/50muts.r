rm(list=ls())
pop = read.csv("50muts.txt")

for(i in c(1:nrow(pop))){

	barplot(c(
		pop[i,1],
		pop[i,2],
		pop[i,3],
		pop[i,4],
		pop[i,5],
		pop[i,6],
		pop[i,7],
		pop[i,8],
		pop[i,9],
		pop[i,10],
		pop[i,11]))
}
