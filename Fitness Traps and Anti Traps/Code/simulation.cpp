#include <iostream>
#include "Rates.h"
#include "Population.h"
#include <vector>
#include <fstream>
#include <algorithm>
#include <cmath>
#include <time.h>
#include <string>

void Do_Statistics(std::vector<std::vector < double>> datai, std::string statisticFileName );

void PopulateAverageArrayTimes(std::vector <std::vector <double>> &avgArray, double step);

int main(){

//########## Parameters to set ########## 

int NUMBER_OF_CELLS = 1000;
int NUMBER_OF_MUTATIONS = 10;

int iterations = 5 ;

double rFlat = 1;
double uFlat = 0.1; 

std::string rLandscape = "FLAT";

double rTrap = 0.5;
int rTrapStart = 3;
int rTrapEnd = 5;

std::string uLandscape = "FLAT";

double uTrap = 0.2;
double uTrapStart = 3;
double uTrapEnd = 5;

//#######################################


clock_t t;
t = clock(); 

auto seed =  std::chrono::high_resolution_clock::now().time_since_epoch().count();
std::mt19937 mt_time(seed);
std::uniform_real_distribution<double> dist(0,1);

std::string fileNameID = std::to_string(seed);

//########## Write parameters to file ##########

std::ofstream parameterOutputFile; 
parameterOutputFile.open(fileNameID + "_Parameters.txt");

parameterOutputFile << "Number of cells: \t " << NUMBER_OF_CELLS << std::endl;
parameterOutputFile << "Number of mutations: \t " << NUMBER_OF_MUTATIONS << std::endl;
parameterOutputFile << "Number of iteration: \t " << iterations << std::endl;
parameterOutputFile << "Fitness Landscape: \t " << rLandscape << std::endl;
parameterOutputFile << "Mutation Landscape: \t " << uLandscape << std::endl;
parameterOutputFile << "Fitness Flat Value: \t " << rFlat << std::endl;
parameterOutputFile << "Mutation Flat Value: \t " << uFlat << std::endl;
//#############################################


Population pop_test(NUMBER_OF_MUTATIONS,NUMBER_OF_CELLS, rFlat, uFlat);

if( rLandscape.compare("FLAT") != 0){

	pop_test.Modify_FitnessLandscape(rTrap, rTrapStart, rTrapEnd);

	parameterOutputFile << "Fitness Trap Value: \t " << rTrap << std::endl;
	parameterOutputFile << "Fitness Trap Start: \t " << rTrapStart << std::endl;
	parameterOutputFile << "Fitness Trap End: \t " << rTrapEnd << std::endl;
}
if( uLandscape.compare("FLAT") != 0 ){

	pop_test.Modify_MutationLandscape(uTrap, uTrapStart, uTrapEnd);

	parameterOutputFile << "Mutation Trap Value: \t " << uTrap << std::endl;
	parameterOutputFile << "Mutation Trap Start: \t " << uTrapStart << std::endl;
	parameterOutputFile << "Mutation Trap End: \t " << uTrapEnd << std::endl;
}

parameterOutputFile.close();

std::vector<double> r = pop_test.Get_FitnessLandscape();
std::vector<double> u = pop_test.Get_MutationLandscape();

Rates rates_test(pop_test.Get_Population(),r,u);

double time = 0;
bool fixxed = false;
int z = 0;

std::string fitnessLandscape = "Flat";  
std::string outputFileName = std::to_string(NUMBER_OF_MUTATIONS) + "Mutations" + std::to_string(NUMBER_OF_CELLS) + "Cells" + std::to_string(iterations) + "Iterations" + fitnessLandscape;

//########## Initialise the average array ########## 

std::vector< std::vector <double>> averageArray;
int finalTime = 250000;
double stepTime = 1;
double timeRows = finalTime/stepTime;

averageArray.resize(timeRows, std::vector<double>(NUMBER_OF_MUTATIONS+1, 0));
PopulateAverageArrayTimes(averageArray, stepTime);

//std::cout << "Initialisation time: " << (float)(clock() - t) << std::endl;


std::ofstream fixationTimeFile;
fixationTimeFile.open(fileNameID + "_FixationTimes.txt");

std::ofstream populationFile;
populationFile.open(fileNameID +"_Populations.txt"); 

while(z < iterations){
	

	std::cout << fileNameID +  " Iteration number: " <<  z << std::endl;

	Population pop_test(NUMBER_OF_MUTATIONS,NUMBER_OF_CELLS, 1, 0.1);
	Rates rates_test(pop_test.Get_Population(),r,u);
	std::vector< std::vector <double>> outputArray;
	bool avgWriteTest = true;
	int avgCounter = 0;

	fixxed = false;
	time = 0;

//	std::cout << "Made it to the loop" << std::endl;

	while (!fixxed) {

//std::cout << "One reaction: " << std::endl;
//t = clock();
 
		if ( pop_test.Fixation_Test() ) {
			//std::cout << "Fixation Time: " <<  averageArray.at(avgCounter).at(0)  << std::endl;
			fixationTimeFile <<  averageArray.at(avgCounter).at(0)  << std::endl;
			fixxed = pop_test.Fixation_Test();
			
t = clock();
			while(avgCounter < averageArray.size()){
				averageArray.at(avgCounter).at(NUMBER_OF_MUTATIONS) = averageArray.at(avgCounter).at(NUMBER_OF_MUTATIONS) +  NUMBER_OF_CELLS;
				avgCounter ++ ;
			}
//std::cout << "Filling average array " << (float)(clock() - t)/ CLOCKS_PER_SEC << std::endl;
			break;
		}
		

//std::cout << "Fixation test took: " << (float)(clock() - t) << std::endl;
//t = clock(); 

		if(avgWriteTest){
			for (int g = 1; g < NUMBER_OF_MUTATIONS+1; g++) {

				averageArray.at(avgCounter).at(g) = averageArray.at(avgCounter).at(g) +  pop_test.Get_Population().at(g-1);

			}
			avgCounter ++;
		}

//std::cout << "Average write test took: " << (float)(clock() - t) << std::endl;
//t = clock();
 
		double random_1 = dist(mt_time);

		double delta = (1 / rates_test.Get_a0()) * log(1/random_1);

//std::cout << "Time  update took: " << (float)(clock() - t) << std::endl;
//t = clock(); 
		auto change = rates_test.Get_Population_Change();
		
		pop_test.Update(change);

//std::cout << "population update took: " << (float)(clock() - t) << std::endl;
//t = clock(); 
		rates_test.Update(pop_test.Get_Population());

//std::cout << "Rates update took: " << (float)(clock() - t) << std::endl;
//t = clock(); 
		time = time + delta;
		
			
		avgWriteTest = time > averageArray.at(avgCounter).at(0); 
		
//std::cout << "Write test update took: " << (float)(clock() - t) << std::endl;
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

	if(averageArray.at(row).at(NUMBER_OF_MUTATIONS) == NUMBER_OF_CELLS) {
		
		 resizeValue = row + 1;
		 break;
	}

}

averageArray.resize(resizeValue);


for(int row = 0; row < averageArray.size(); row++){
	for( int col = 0; col < averageArray.at(0).size(); col ++){

		populationFile << averageArray.at(row).at(col) << "\t"; 

	}

	populationFile << std::endl; 
}

Do_Statistics(averageArray, fileNameID);


std::cout << "\a" ;

return 0;

}


void Do_Statistics( std::vector < std::vector <double>> data, std::string statisticFileName) {
	std::cout << statisticFileName +  " Doing Stats" << std::endl;

	std::ofstream statisticsOutputFile;
	statisticsOutputFile.open(statisticFileName + "_StatisticOutput.txt");

	std::vector<int> binCount;
	std::vector<double> typeAverage;
	std::vector<double> velocityArray;
	std::vector<double> varianceiArray;	

	std::vector<int> weights;
	std::vector<int> weightsSquared;

	double maxCellNumber = data.at(0).at(1);

	for(int i =0; i < data.at(0).size(); i++){
		weights.push_back(i);
		weightsSquared.push_back(i*i);
	} 

	//Type average is the dot product between the 0:number_muts 
	//Bin count is counting the non zero bins

	for(int rows=0; rows < data.size(); rows++){

		auto countt = std::count(data.at(rows).begin()+1, data.at(rows).end(), 0); 
		binCount.push_back(data.at(rows).size() - 1 - countt);	


		double dotProduct = inner_product(data.at(rows).begin()+1, data.at(rows).end(), weights.begin(), 0)/maxCellNumber;
		typeAverage.push_back(dotProduct);

		double variance = inner_product(data.at(rows).begin()+1, data.at(rows).end(), weightsSquared.begin(), 0)/(maxCellNumber) - (dotProduct*dotProduct); 
		variance = std::sqrt(variance);

		varianceiArray.push_back(variance);

		if(rows == 0){
			velocityArray.push_back(0);
		}
		else{
			double velocity = (typeAverage.at(rows) - typeAverage.at(rows-1))/(data.at(rows).at(0) - data.at(rows-1).at(0));
			velocityArray.push_back(velocity);
		}

	} 


	//wirting to a file the r$i is for ggplot
	statisticsOutputFile << "Time" << "\t" << "Displacement" << "\t" << "BinCount" << "\t" << "Variance" << "\t" << "Velocity" << "\t" << "Label" << std::endl; 

	for(int j = 0; j < binCount.size(); j++){
		statisticsOutputFile << data.at(j).at(0) << "\t"  << typeAverage.at(j) << "\t" << binCount.at(j) << "\t"  <<
						varianceiArray.at(j) << "\t" << velocityArray.at(j) << "\t" << statisticFileName  << std::endl;
	}

	statisticsOutputFile.close();

}

void PopulateAverageArrayTimes(std::vector <std::vector <double>> &avgArray, double step){

	for(double i = 0; i < avgArray.size(); i++){

		avgArray.at(i).at(0) = i*step;
		

		//std::cout << "Populating " << i*step << "\t" << avgArray.at(i).at(0) <<   std::endl;
	}

}
