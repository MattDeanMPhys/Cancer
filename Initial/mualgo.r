rm(list=ls())

a = sample(seq(0,1, by=0.1), 6,replace=T)
r = sample(seq(0,1, by=0.1), 1,replace=T)

target = a[1]*r
x=1
mu = 6

while(mu != 0){


	sum_big = sum(a[1:mu])
	sum_small =  sum(a[1:mu-1])


	sum_big_test = target <= sum_big
	sum_small_test = target > sum_small
	if(sum_big_test){
		if(sum_small_test){
			print(mu)
		}
	}

	mu = mu - 1
}
