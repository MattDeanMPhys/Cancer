TrapDrawer <- function(data, L) {

	params = data
	#params = read.csv("471194581834725_Parameters.txt", sep = "\t", head= F, stringsAsFactors=FALSE, strip.white = TRUE)

	lengthOfTrap = as.numeric(params$V2[2])
	fitnessFlat = as.numeric(params$V2[6])
	mutationFlat = as.numeric(params$V2[7])

	fitnessLandscape = rep.int(fitnessFlat, lengthOfTrap)
	 
	mutationLandscape = rep.int(mutationFlat, lengthOfTrap)

	if( params$V2[4] != "FLAT"){

		modValue = as.numeric(params$V2[8])
		modStart = as.numeric(params$V2[9])
		modFinish = as.numeric(params$V2[10])

		for(i in c(modStart:modFinish)){
			
			fitnessLandscape[i] = modValue		

		}

	}

	if( params$V2[5] != "FLAT"){

	}

	fitnessLandscape = fitnessLandscape / max(fitnessLandscape)
	mutationLandscape = mutationLandscape / max(mutationLandscape)

	landscapes_fit = data.frame( c(1:lengthOfTrap), fitnessLandscape, rep.int("Fitness", lengthOfTrap))
	landscape_mut =  data.frame( c(1:lengthOfTrap), mutationLandscape, rep.int("Mutation", lengthOfTrap))

	names(landscapes_fit) = c("CellType", "Value", "Landscape")
	names(landscape_mut) = c("CellType", "Value", "Landscape")

	landscapeCombo = rbind(landscapes_fit, landscape_mut)
	
	
	if(L == "F"){
		return(landscapes_fit)
	}
	if(L == "M"){
		return(landscape_mut)
	}

}
