if(!exists("data")){

	data = 	read.csv("3muts.txt", sep = "\t", head=F)
	
}
cells = data[1,2]
weights = c(0:2)

pops = data[c("V2", "V3", "V4")]
pops_r = pops/cells

a = weighted.mean(pops_r[1,], weights) 
b = weighted.mean(pops_r[2,], weights) 

means = apply(pops_r, 1, function(x) weighted.mean(x, weights))

w_mean_data = c(1:nrow(pops_r))

if(FALSE){
for( i in c(1:nrow(pops_r))){

	w_mean = 0 

	for(j in c(1:ncol(pops_r))){

		w_mean = pops_r[i,j]*weights[j]

	}

	w_mean_data[i] = w_mean
}
}

bin_count = c(1:nrow(pops_r))

for( k in bin_count){

	bin_count[k] = length(which(pops_r[k,]==0))
}



