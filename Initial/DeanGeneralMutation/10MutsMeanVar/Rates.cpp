#include "Rates.h"
#include <numeric>
#include <vector> 
#include <iostream>
#include <random>
#include <chrono>

auto seed = std::chrono::high_resolution_clock::now().time_since_epoch().count();
std::mt19937 mt(seed);
std::uniform_real_distribution<double> dist(0,1);


Rates::Rates(std::vector<int> n, std::vector<double> r, std::vector<double> u) { 

	populations = n;
	fitness = r;
	mutate = u;


	Total_Cells();
	Calculate_rbar();
	Generate_Random_Number();

	Generate_Rates();
	
	Find_Mu();	

	//std::cout << "Object created" << std::endl;

}

void Rates::Calculate_rbar() {

	rbar = inner_product(populations.begin(), populations.end(), fitness.begin(), 0)/total_number_cells;
}

void Rates::Print_Vars() {

	std::cout << "rbar: " << rbar << std::endl;
	std::cout << "Random Numbers: " << random_number << std::endl;
	std::cout << "mu: " << mu << std::endl;
	std::cout << "Dim: " << populations.size() << std::endl;
	std::cout << "a0: " << a0 << std::endl;

}

void Rates::Generate_Rates() {

	rates.resize(populations.size(), std::vector<double> (populations.size(), 0));

	for(int rows = 0; rows < populations.size(); rows++){
		for( int cols = 0; cols < populations.size(); cols++){

			rates.at(rows).at(cols) = Calculate_Rates(rows, cols, rbar);

			a0 = a0 + rates.at(rows).at(cols);
		}
	}

}

void Rates::Print_Rates() {

	for(int rows = 0; rows < populations.size(); rows ++) {

		for(int cols = 0; cols < populations.size(); cols ++) {

			std::cout << rates.at(rows).at(cols) << "\t" ;
		}
	std::cout << std::endl; 
	}
}
	

double Rates::Calculate_Rates(int j, int i, double rbar) { 

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

void Rates::Total_Cells() {

	double N = 0 ;

	for(int i = 0; i < populations.size(); i++) {
	
		N = N + populations.at(i);

	}

	total_number_cells = N;
}

void Rates::Generate_Random_Number() {


	random_number = dist(mt);

}

void Rates::Find_Mu()	{

	int test_mu = 1; 
	double small_sum = 0;
	double big_sum = 0;

	Generate_Random_Number();

	double target = a0 * random_number;

	for( int rows = 0; rows < populations.size(); rows++){
		for( int cols = 0; cols < populations.size(); cols++){

			small_sum = big_sum;

			big_sum = big_sum + rates.at(cols).at(rows) ;

			bool small_sum_test = small_sum < target;
			bool big_sum_test = big_sum >= target;

			if(small_sum_test && big_sum_test){
				mu = test_mu ;
				mu_birth = rows;
				mu_death = cols; 
				
				break;
			}
			else {
				test_mu ++;
			}
 		}
	}

}

void Rates::Update( std::vector<int> n ) {

	populations = n;

	Calculate_rbar();

	a0 = 0;

	for(int rows = 0; rows < populations.size(); rows++){
		for( int cols = 0; cols < populations.size(); cols++){

			rates.at(rows).at(cols) = Calculate_Rates(rows, cols, rbar);

			a0 = a0 + rates.at(rows).at(cols);
		}
	}

	Find_Mu();


}

std::vector<int> Rates::Get_Population_Change() {

	std::vector<int> populationchange (2,0); 

	populationchange.at(0) = mu_death;
	populationchange.at(1) = mu_birth;

	return populationchange;

}

double Rates::Get_a0() {

	return a0;	

}

