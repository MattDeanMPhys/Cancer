#ifndef RATES_H
#define RATES_H
#include <vector>
#include <random>


class Rates {


	int mu;
	int mu_birth;
	int mu_death;

	double random_number;
	double rbar;	
	double total_number_cells;
	double a0;
	
		
	std::vector<int> populations;
	std::vector<double> fitness;
	std::vector<double> mutate;	

	std::vector < std::vector < double >> rates; 

	public:
		Rates( std::vector<int>, std::vector<double>, std::vector<double> );
		void Find_Mu();
		void Generate_Random_Number();
		void Calculate_rbar();
		void Print_Vars();
		void Generate_Rates();
		void Print_Rates();
		double Calculate_Rates(int, int, double);
		void Total_Cells();
		void Update(std::vector<int>);
		std::vector<int> Get_Population_Change();
		double Get_a0();


};

#endif 
