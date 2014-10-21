#include <iostream>
#include "Rates.h"
#include "Population.h"
#include <vector>
#include <fstream>
#include <algorithm>
#include <cmath>

void Do_Statistics(std::vector<std::vector < double>> data );

void PopulateAverageArrayTimes(std::vector <std::vector <double>> &avgArray, double step);

std::vector< std::vector <double>> Condense(std::vector<std::vector<double>> arr, double timeStep);  

int main(){

auto seed = 10;
std::mt19937 mt_time(seed);
std::uniform_real_distribution<double> dist(0,1);



int NUMBER_OF_CELLS = 10000;
int NUMBER_OF_MUTATIONS = 10;

std::vector<double> r(NUMBER_OF_MUTATIONS, 1);
std::vector<double> u(NUMBER_OF_MUTATIONS, 0.1);
u.at(0) = 0;
u.push_back(0);


Population pop_test(NUMBER_OF_MUTATIONS,NUMBER_OF_CELLS);
Rates rates_test(pop_test.Get_Population(),r,u);

double time = 0;
bool fixxed = false;

int iterations = 25 ;
int z = 0;

std::vector< std::vector <double>> averageArray;
int finalTime = 250000;
double stepTime = 1;
double timeRows = finalTime/stepTime;

averageArray.resize(timeRows, std::vector<double>(NUMBER_OF_MUTATIONS+1, 0));
PopulateAverageArrayTimes(averageArray, stepTime);


while(z < iterations){
	
	
	std::cout << z  << std::endl;

	Population pop_test(NUMBER_OF_MUTATIONS,NUMBER_OF_CELLS);
	Rates rates_test(pop_test.Get_Population(),r,u);
	std::vector< std::vector <double>> outputArray;
	bool avgWriteTest = true;
	int avgCounter = 0;

	fixxed = false;
	time = 0;

	while (!fixxed) {


		if ( pop_test.Fixation_Test() ) {
			std::cout << "Fixed!" << std::endl;
			fixxed = pop_test.Fixation_Test();
			
			averageArray.at(avgCounter).at(NUMBER_OF_MUTATIONS) = NUMBER_OF_CELLS;
			
			break;
		}
		

		if(avgWriteTest){
			for (int g = 1; g < NUMBER_OF_MUTATIONS+1; g++) {

				averageArray.at(avgCounter).at(g) = averageArray.at(avgCounter).at(g) +  pop_test.Get_Population().at(g-1);

			}
			avgCounter ++;
		}


		double random_1 = dist(mt_time);

		double delta = (1 / rates_test.Get_a0()) * log(1/random_1);

		auto change = rates_test.Get_Population_Change();
		
		pop_test.Update(change);

		rates_test.Update(pop_test.Get_Population());

		time = time + delta;
		
			
		avgWriteTest = time > averageArray.at(avgCounter).at(0); 
		
	}

	z++;
		
}


int resizeValue;

for(int row = 0; row < averageArray.size(); row++){

	double maxSizeSum = 0;

	for( int col = 1; col < averageArray.at(0).size(); col ++){

		averageArray.at(row).at(col) =  averageArray.at(row).at(col) /iterations ; 
		maxSizeSum += averageArray.at(row).at(col); 
	}

	if( maxSizeSum == 0) {
		
		 resizeValue = row;
		 break;
	}

}

averageArray.resize(resizeValue);

for(int row = 0; row < averageArray.size(); row++){
	for( int col = 0; col < averageArray.at(0).size(); col ++){

		std::cout << averageArray.at(row).at(col) << "\t"; 

	}

	std::cout << std::endl; 
}

Do_Statistics(averageArray);


return 0;

}


void Do_Statistics( std::vector < std::vector <double>> data) {
	std::cout << "Doing Stats" << std::endl;
	
	std::string rchange = "flat";

	std::ofstream statisticsOutputFile;
	statisticsOutputFile.open("Statistic_Output_" + rchange +".txt");

	std::vector<int> binCount;
	std::vector<double> typeAverage;

	std::vector<int> weights;

	double maxCellNumber = data.at(0).at(1);

	for(int i =0; i < data.size(); i++){
		weights.push_back(i);
	} 

	//Type average is the dot product between the 0:number_muts 
	//Bin count is counting the non zero bins

	for(int rows=0; rows < data.size(); rows++){

		auto countt = std::count(data.at(rows).begin()+1, data.at(rows).end(), 0); 
		binCount.push_back(data.at(rows).size() - 1 - countt);	

		double dotProduct = inner_product(data.at(rows).begin()+1, data.at(rows).end(), weights.begin(), 0)/maxCellNumber;
		typeAverage.push_back(dotProduct);

	} 


	//wirting to a file the r$i is for ggplot
	for(int j = 0; j < binCount.size(); j++){
		statisticsOutputFile << data.at(j).at(0) << "\t"  << typeAverage.at(j) << "\t" << binCount.at(j) << "\t" << rchange << std::endl;
	}

	statisticsOutputFile.close();

}

void PopulateAverageArrayTimes(std::vector <std::vector <double>> &avgArray, double step){

	for(double i = 0; i < avgArray.size(); i++){

		avgArray.at(i).at(0) = i*step;
		

		//std::cout << "Populating " << i*step << "\t" << avgArray.at(i).at(0) <<   std::endl;
	}

}
