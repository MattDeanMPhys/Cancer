#ifndef POPULATION_H
#define POPULATION_H
#include <vector>

class Population {

	int number_of_mutations;
	int total_number_of_cells;

	

	std::vector<int> cells;

	public:

		Population(int, int);
		void Print_Population();
		void Cell_Death(int);
		void Cell_Birth(int); 
		std::vector<int> Get_Population(); 
		void Update( std::vector<int>); 
		bool Fixation_Test();
};




#endif
