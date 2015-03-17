#ifndef POPULATION_H
#define POPULATION_H
#include <vector>

class Population {

	int number_of_mutations;
	int total_number_of_cells;
	
	std::vector<int> cells;
	std::vector<double> fitness;
	std::vector<double> mutation;

	public:

		Population(int, int, double, double);
		void Print_Population();
		void Cell_Death(int);
		void Cell_Birth(int); 
		std::vector<int> Get_Population(); 
		void Update( std::vector<int>); 
		bool Fixation_Test();

		void Generate_FitnessLandscape(double);
		void Modify_FitnessLandscape(double, int, int);

		void Generate_MutationLandscape(double);
		void Modify_MutationLandscape(double, int, int);

		std::vector<double> Get_MutationLandscape();
		std::vector<double> Get_FitnessLandscape();

		void Manual_MutationLandscape(std::vector<double>);
};




#endif
