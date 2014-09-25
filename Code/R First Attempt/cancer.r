rm(list=ls())



birth <- function(fitness, mutation, population){
	weight = sum(fitness*population)
	prob = c((fitness[1]*population[1]*(1-mutation[1]))/weight)

	prob = c(prob, (( fitness[1]*population[1]*mutation[1] + fitness[2]*population[2]*(1 - mutation[2]))/weight))

	prob = c(prob, (( fitness[2]*population[2]*mutation[2] + fitness[3]*population[3])/weight))

	return(prob)

}

trials = 100

N = 10

r1 = 1
r2 = 1.0  #need to vary this to produce a graph.
r3 =1.0

u1 = 0.1
u2 = 0.1

r = c(r1, r2, r3)
n = c(N,0,0)
u = c(u1, u2)


t = 0
T = 100

x= 0 
trials = 1000

sum = 0 

results = 0

span = seq(0, 10, length.out=30)

for(i in 1:30) {

	x =0 
	r[2] = span[i]

	while(x < trials){
	t = 0
		while(t<T){
			pr_death = n/sum(n)
			pr_birth = birth(r,u,n)


			death_cell = sample(c(1,2,3),1,F,pr_death)
			birth_cell = sample(c(1,2,3),1,F,pr_birth)

			n[death_cell] = n[death_cell] - 1
			n[birth_cell] = n[birth_cell] + 1
			t= t+1
		}

		if(n[3]==10){

			sum = sum + 1
		}
		n = c(N,0,0)
		x = x + 1
	}

	results = c(results, sum)
}
plot(span, (results/trials)[2:length(results)])
