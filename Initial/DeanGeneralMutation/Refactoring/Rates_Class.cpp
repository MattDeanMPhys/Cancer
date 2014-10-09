#include <numeric>
#include <vector> 
#include <iostream>
#include <random>
#include <chrono>

class Transmission_Rates_Data {

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
		Transmission_Rates_Data( std::vector<int>, std::vector<double>, std::vector<double> );
		void Find_Mu();
		void Rates();
		void Generate_Random_Number();
		void Calculate_rbar();
		void Print_Vars();
		void Generate_Rates();
		void Print_Rates();
		double Calculate_Rates(int, int, double);
		void Total_Cells();

};

Transmission_Rates_Data::Transmission_Rates_Data(std::vector<int> n, std::vector<double> r, std::vector<double> u) { 

	populations = n;
	fitness = r;
	mutate = u;


	Total_Cells();
	Calculate_rbar();
	Generate_Random_Number();

	Generate_Rates();


	std::cout << "Object created" << std::endl;

}

void Transmission_Rates_Data::Calculate_rbar() {

	rbar = inner_product(populations.begin(), populations.end(), fitness.begin(), 0)/total_number_cells;
}

void Transmission_Rates_Data::Print_Vars() {

	std::cout << "rbar: " << rbar << std::endl;
	std::cout << "Random Numbers: " << random_number << std::endl;
	std::cout << "mu: " << mu << std::endl;
	std::cout << "Dim: " << populations.size() << std::endl;
	std::cout << "a0: " << a0 << std::endl;

}

void Transmission_Rates_Data::Generate_Rates() {

	rates.resize(populations.size(), std::vector<double> (populations.size(), 0));

	for(int rows = 0; rows < populations.size(); rows++){
		for( int cols = 0; cols < populations.size(); cols++){

			rates.at(rows).at(cols) = Calculate_Rates(rows, cols, rbar);

			a0 = a0 + rates.at(rows).at(cols);
		}
	}

}

void Transmission_Rates_Data::Print_Rates() {

	for(int rows = 0; rows < populations.size(); rows ++) {

		for(int cols = 0; cols < populations.size(); cols ++) {

			std::cout << rates.at(rows).at(cols) << "\t" ;
		}
	std::cout << std::endl; 
	}
}
	

double Transmission_Rates_Data::Calculate_Rates(int j, int i, double rbar) { 

	double tr;

	if(j==i){
		tr = 0;
		return tr;
	}

	if((i-1) < 0) { 

		tr = ( ( 1-mutate[i+1] )*fitness[i]) * ( populations[i]/total_number_cells ) * (populations[j] / rbar) ;

	}
	else { 
		tr = ( ( (mutate[i]*fitness[i-1]) * ( populations[i-1]/total_number_cells ) ) + ( ( 1-mutate[i+1] )*fitness[i]*( populations[i]/total_number_cells ) ) ) * ( populations[j] / rbar);

 

	} 
	return tr; 
} 

void Transmission_Rates_Data::Total_Cells() {

	double N = 0 ;

	for(int i = 0; i < populations.size(); i++) {
	
		N = N + populations.at(i);

	}

	total_number_cells = N;
}

void Transmission_Rates_Data::Generate_Random_Number() {
	auto seed = 10;
	//auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
	std::mt19937 mt(seed);
	std::uniform_real_distribution<double> dist(0,1);

	random_number = dist(mt);

}

void Transmission_Rates_Data::Find_Mu()	{

	int test_mu = 1; 
	double small_sum = 0;
	double big_sum = 0;

	double target = a0 * random_number;

	for( int i = 0; i < populations.size(); i++){
		for( int j = 0; j < populations.size(); j++){

			small_sum = big_sum;

			big_sum = big_sum + rates.at(j).at(i) ;

			bool small_sum_test = small_sum < target;
			bool big_sum_test = big_sum >= target;

			if(small_sum_test && big_sum_test){
				mu = test_mu ;
				break;
			}
			else {
				test_mu ++;
			}
 		}
	}

}


int main() {


std::vector<int> n {8, 2, 0}; 
std::vector<double> r {1,1,1};
std::vector<double>  u {0 , 0.1, 0.1, 0};

Transmission_Rates_Data trans(n,r,u);

trans.Print_Vars();
trans.Print_Rates();
trans.Find_Mu();

trans.Print_Vars();

return 0;
}	

