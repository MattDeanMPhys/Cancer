#include <iostream>
#include "Rates.h"
#include "Population.h"
#include <vector>

int main(){

auto seed = 10;
std::mt19937 mt_time(seed);
std::uniform_real_distribution<double> dist(0,1);



std::vector<double> r = {1,1,1};

std::vector<double> u = {0,0.1,0.1,0};

int NUMBER_OF_CELLS = 10000;
int NUMBER_OF_MUTATIONS = 3;

Population pop_test(NUMBER_OF_MUTATIONS,NUMBER_OF_CELLS);
Rates rates_test(pop_test.Get_Population(),r,u);

double time = 0;
double time_end = 10;
bool fixxed = false;

int MAX_ITERATIONS = 250000;
int iterations = 0;

while (iterations < MAX_ITERATIONS) {


	for (int g = 0; g < NUMBER_OF_MUTATIONS; g++) {

		std::cout << pop_test.Get_Population().at(g) << "\t";
	}

	std::cout << std::endl; 	

	double random_1 = dist(mt_time);

	double delta = (1 / rates_test.Get_a0()) * log(1/random_1);

	auto change = rates_test.Get_Population_Change();
	
	pop_test.Update(change);
	
/*	if ( pop_test.Fixation_Test() ) {
		
		fixxed = pop_test.Fixation_Test();
		std::cout << 0 << "\t" << 0 << "\t" << NUMBER_OF_CELLS << "\t" << std::endl;
		break;
	}
*/
	rates_test.Update(pop_test.Get_Population());

	time = time + delta;

	iterations ++;

}

std::cout << "99999" << std::endl;
//std::cout <<  time  << std::endl;

return 0;

}
