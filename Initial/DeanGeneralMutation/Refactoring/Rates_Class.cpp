#include <numeric>
#include <vector> 
#include <iostream>


class Transmission_Rates_Data {

	int mu;
	int random_number;
	double rbar;	

	std::vector<int> populations;
	std::vector<double> fitness;
	std::vector<double> mutate;	

	public:
		Transmission_Rates_Data( std::vector<int>, std::vector<double>, std::vector<double> );
		void Find_Mu();
		void Rates();
		void Generate_Random_Number();
		void Calculate_rbar();
};

Transmission_Rates_Data::Transmission_Rates_Data(std::vector<int> n, std::vector<double> r, std::vector<double> u) { 
	populations = n;
	fitness = r;
	mutate = u;
	Calculate_rbar();
}

void Transmission_Rates_Data::Calculate_rbar() {

	rbar = inner_product(populations.begin(), populations.end(), fitness.begin(), 0);
}
	

int main() {


std::vector<int> n;
std::vector<double> r, u;


return 0;
}	

