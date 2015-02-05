#include "Population.h" 
#include <iostream>
#include <vector>


Population::Population(int mutationsNumber, int cellNumber, double fitnessValue, double mutationValue){

	number_of_mutations = mutationsNumber;
	total_number_of_cells = cellNumber;

	cells.assign(number_of_mutations, 0);	
	cells.at(0) = total_number_of_cells;

	Generate_FitnessLandscape(fitnessValue);
	Generate_MutationLandscape(mutationValue);

}

void Population::Print_Population(){

	for(int i =0; i < number_of_mutations; i++){
		std::cout << "Type " << i << ": " << cells.at(i) << "\t" ;
	}
	std::cout << "\n" ;
}

void Population::Cell_Death(int type){

	cells.at(type) --;

}	

void Population::Cell_Birth(int type){

	cells.at(type) ++;

}	

std::vector<int> Population::Get_Population(){

	return cells;

}

void Population::Update(std::vector<int> change) {

	int cell_death = change.at(0);
	int cell_birth = change.at(1);

	if(! Fixation_Test()){

		Cell_Death(cell_death);
		Cell_Birth(cell_birth);
	}
}
	

bool Population::Fixation_Test(){

	if(cells.at(number_of_mutations-1) == total_number_of_cells){
		return true;
	}
	return false;
	
}
 

void Population::Generate_FitnessLandscape(double value){

	fitness.assign(number_of_mutations, value); 

}

void Population::Modify_FitnessLandscape(double trapValue, int startValue, int endValue){

	for(int i = startValue; i < endValue; i++){
		
		fitness.at(i) = trapValue;
	}
}


void Population::Generate_MutationLandscape(double value){

	mutation.assign(number_of_mutations, value);

	mutation.at(0) = 0;
	mutation.push_back(0);

}

void Population::Modify_MutationLandscape(double trapValue, int startValue, int endValue){

	for(int i = startValue; i < endValue; i++){
		
		mutation.at(i) = trapValue;
	}
	
	mutation.at(0) = 0;
	mutation.push_back(0);
		
}

std::vector<double> Population::Get_MutationLandscape(){

	return mutation;
}

std::vector<double> Population::Get_FitnessLandscape(){

	return fitness;
}

void Population::Manual_MutationLandscape(std::vector<double> u){

	mutation = u; 
}




