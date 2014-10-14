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

std::ofstream outputFile;
outputFile.open("Output.txt");


int NUMBER_OF_CELLS = 1000;
int NUMBER_OF_MUTATIONS = 5;

std::vector<double> r(NUMBER_OF_MUTATIONS, 1);
std::vector<double> u(NUMBER_OF_MUTATIONS, 0.1);
u.at(0) = 0;
u.push_back(0);

Population pop_test(NUMBER_OF_MUTATIONS,NUMBER_OF_CELLS);
Rates rates_test(pop_test.Get_Population(),r,u);

double time = 0;
double time_end = 10;
bool fixxed = false;

int iterations = 1000 ;
int z = 0;

std::vector< std::vector <double>> averageArray;
int finalTime = 250;
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

	//	std::vector <double> outputRow(NUMBER_OF_MUTATIONS + 1, 0);
	//	outputRow.at(0) = time;

		if ( pop_test.Fixation_Test() ) {

			fixxed = pop_test.Fixation_Test();

	//		outputRow.at(NUMBER_OF_MUTATIONS) = NUMBER_OF_CELLS;

	//		outputArray.push_back(outputRow);
			
			averageArray.at(avgCounter).at(NUMBER_OF_MUTATIONS) = NUMBER_OF_CELLS;
			
			break;
		}
		
			//std::cout << "Counter: " << avgCounter << "\t" << avgWriteTest << std::endl;

		if(avgWriteTest){
			for (int g = 1; g < NUMBER_OF_MUTATIONS+1; g++) {

	//			outputRow.at(g) = pop_test.Get_Population().at(g-1);
				averageArray.at(avgCounter).at(g) = averageArray.at(avgCounter).at(g) +  pop_test.Get_Population().at(g-1);
//				std::cout << pop_test.Get_Population().at(g-1) << std::endl;

			}
			avgCounter ++;
		}

	//	outputArray.push_back(outputRow);

		double random_1 = dist(mt_time);

		double delta = (1 / rates_test.Get_a0()) * log(1/random_1);

		auto change = rates_test.Get_Population_Change();
		
		pop_test.Update(change);

		rates_test.Update(pop_test.Get_Population());

		time = time + delta;
		
		//std::cout << "Time: " << time << "\t Step" << averageArray.at(avgCounter).at(0) << std::endl;
			
		avgWriteTest = time > averageArray.at(avgCounter).at(0); 
		
		//std::cout << avgWriteTest << std::endl; 
	}

	z++;


	for(int rows = 0; rows < averageArray.size(); rows++){
		for(int cols = 0; cols < averageArray[0].size(); cols++){

//			std::cout << averageArray.at(rows).at(cols) << "\t";

		}

//		std::cout << std::endl;

	}
		
}

//Writing outputArray to file
/*
for(int rows = 0; rows < outputArray.size(); rows++){
	for(int cols = 0; cols < outputArray[0].size(); cols++){

		outputFile << outputArray.at(rows).at(cols) << "\t";

	}

	outputFile << std::endl;

}
*/
outputFile.close();

//Do_Statistics(outputArray);


return 0;

}


void Do_Statistics( std::vector < std::vector <double>> data) {
	std::cout << "Doing Stats" << std::endl;

	std::ofstream statisticsOutputFile;
	statisticsOutputFile.open("Statistic_Output.txt");

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


	//wirting to a file
	for(int j = 0; j < binCount.size(); j++){
		statisticsOutputFile << data.at(j).at(0) << "\t"  << typeAverage.at(j) << "\t" << binCount.at(j) << std::endl;
	}

	statisticsOutputFile.close();

}

void PopulateAverageArrayTimes(std::vector <std::vector <double>> &avgArray, double step){

	for(double i = 0; i < avgArray.size(); i++){

		avgArray.at(i).at(0) = i*step;
		

		//std::cout << "Populating " << i*step << "\t" << avgArray.at(i).at(0) <<   std::endl;
	}

}

std::vector< std::vector <double>> Condense(std::vector<std::vector<double>> arr, double timeStep) { 

	std::cout << "Entering condense" << std::endl;

	std::cout << arr.at(arr.size()-1).at(0) << std::endl;

	double finalTime = floor(arr.at(arr.size()-1).at(0));


	double timeSize = finalTime/timeStep;

	std::vector<double> times(timeSize, 0);

	for(double i = 1; i < times.size(); i++){
		times.at(i) = i*timeStep;
		double target = i*timeStep;

		while( arr.at(i).at(0) < (target)){
			//std::cout << "arr.at(i).at(0) " << arr.at(i).at(0) << "\t i x timestep " << (i*timeStep) <<  std::endl;
			arr.erase(arr.begin()+i);
		}

		arr.at(i).at(0) = i*timeStep;

		std::cout <<  i/finalTime << std::endl;
	}
	return arr;
}


