#include "Population.h" 
#include <iostream>
#include <vector>


Population::Population(int mutations, int cell){

	number_of_mutations = mutations;
	total_number_of_cells = cell;

	cells.assign(number_of_mutations, 0);	

	cells.at(0) = total_number_of_cells;

}

void Population::Print_Population(){

	for(int i =0; i < number_of_mutations; i++){
		std::cout << "Type " << i << ": " << cells.at(i) << std::endl;
	}

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


