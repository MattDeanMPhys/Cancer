#ifndef RATES_H
#define RATES_H
#include <vector>


class Rates {

	int mu;
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
		//void Rates();
		void Generate_Random_Number();
		void Calculate_rbar();
		void Print_Vars();
		void Generate_Rates();
		void Print_Rates();
		double Calculate_Rates(int, int, double);
		void Total_Cells();



};

#endif 
