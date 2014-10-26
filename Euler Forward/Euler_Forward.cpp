#include <iostream> 
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>

using namespace std; 

/* ----------- Define Constants ----------- */

double totalTime; 
double numSteps; 
double timeStep;
int numMutations;
double N;
double t = 0;

vector<double> r; 
vector<double> x;
vector<double> u;

/* ---------------------------------------- */

double generateConcentrationRate(int i, double rbar) { 
	double concentrationRate;
	if((i-1) < 0) { 
		 concentrationRate = ( ( ( ( 1 - u[i+1] )*r[i] - rbar )*x[i] ) ) / rbar; 
	}
	else { 
		concentrationRate = ( ( u[i]*r[i-1]*x[i-1] ) + ( ( ( 1 - u[i+1] )*r[i] - rbar )*x[i] ) ) / rbar; 
 	} 
	return concentrationRate; 
}


void read_data(string file) { 
	ifstream myReadFile;
 	myReadFile.open(file);
 	
 	int line=0; 
 	double r_dum, u_dum, N_dum, totalTime_dum, numSteps_dum; 
 	cout << "Reading in data...." << endl;
 	if (myReadFile.is_open()) {
 		myReadFile >> N_dum >> totalTime_dum >> numSteps_dum;
  	}
  	cout << "constant variables have been read in...." << endl;
  	totalTime = totalTime_dum; numSteps = numSteps_dum; N = N_dum;
  	cout << totalTime_dum << "\t" << numSteps_dum << endl;
  	cout << totalTime << "\t" << numSteps << endl;
 	if (myReadFile.is_open()) {
 		while (!myReadFile.eof()) {
 				myReadFile >> r_dum >> u_dum; 
 				r.push_back(r_dum); 
 				u.push_back(u_dum); 
 				line++;
 		}
	}

	cout << "finished reading in u's and r's" << endl;

	numMutations = (line-1); 
	u.push_back(0);

	x.clear();
	for(int k = 0; k < line; k++) { 
		x.push_back(0);
	}

	myReadFile.close();
}


int main(int argc, char** argv) { 
	string file; 
	if(argc != 2) {cout << "Too many arguments, program exiting!" << endl; exit(0); }
	else { file = argv[1]; } 

	read_data(file);

	x[0] = N/N; 

	double dx[numMutations+1]; 
	double rbar = 0;

	timeStep = totalTime / numSteps;
	
	cout << "r values: " << endl;
	for(int i = 0; i < r.size(); i++) { 
		cout << r[i] << ", ";
	}
	cout << "\n";
	cout << "u values: " << endl;
	for(int i = 0; i < u.size(); i++) { 
		cout << u[i] << ", ";
	}
	cout << "\n";
	
	ofstream myfile ("EF.txt");
	for(int j = 0; j < numSteps; j++) { 
		
		for(int l = 0; l < x.size(); l++) { 
			rbar += r[l]*x[l];
			myfile << x[l]*N << ", "; 
		}
		myfile << t << endl;

		for(int k = 0; k < x.size(); k++) { 
			dx[k] = generateConcentrationRate(k, rbar);
		}

		for(int m = 0; m < x.size(); m++) { 
			x[m] = x[m] + timeStep*dx[m];
		}

		if(j%100000) { 
			//cout << t << endl;
		}
		t += timeStep; 
		rbar = 0;
	}
	cout << "Final time: " << t << endl;
	return 0; 
}