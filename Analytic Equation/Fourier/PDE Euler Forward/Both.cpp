#include <iostream> 
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <math.h>       /* round, floor, ceil, trunc */
#include <string>
#include <string.h>
#include <fstream>
#include <sstream>
#include <stdlib.h>

using namespace std; 

/* ----------- Define Constants ----------- */
int numMutations;
double totalTime; 
int numSteps; 
double timeStep;
double N;
double t = 0;
int averageNumber = 1*pow(10,2);

//vector <double> r (numMutations+1,1); 
//vector <double> u (numMutations+2,0.1);

vector <double> r;
vector <double> u;

/* ---------------------------------------- */

// Define a decent random number generator
auto s = chrono::high_resolution_clock::now().time_since_epoch().count();
mt19937 mt(s);
uniform_real_distribution<double> dist(0,1);

template <typename T>
string to_string ( T Number )
{
	stringstream ss;
	ss << Number;
	return ss.str();
}

// Generate concentration rates
double generateConcentrationRate(vector< vector<double> > &x, int i, int j, double rbar) { 
	double concentrationRate;
	if((i-1) < 0) { 
		 concentrationRate = ( ( ( ( 1 - u[i+1] )*r[i] - rbar )*x[j][i] ) ) / rbar; 
	}
	else { 
		concentrationRate = ( ( u[i]*r[i-1]*x[j][i-1] ) + ( ( ( 1 - u[i+1] )*r[i] - rbar )*x[j][i] ) ) / rbar; 
 	} 
	return concentrationRate; 
}

// Generate populations
void EulerRunTime(vector< vector<double> > &x, vector< vector<double> > &dx) { 
	double rbar = 0;
	for(int j = 0; j < numSteps; j++) { 
		rbar = 0;
		for(int l = 0; l < (numMutations+1); l++) { 
			rbar += r[l]*x[j][l];
		}
		
		for(int k = 0; k < (numMutations+1); k++) { 
			dx[j][k] = generateConcentrationRate(x, k, j, rbar);
		}
		
		for(int m = 0; m < (numMutations+1); m++) { 
			x[j+1][m] = x[j][m] + timeStep*dx[j][m];
		}

		t += timeStep; 
		rbar = 0;

		if(j%(numSteps/10) == 0) { 
			cout << j << endl;
		}
	}
}

// Explode functions given a delimiter
vector<string> &split(const string &s, char delim, vector<string> &elems) {
    stringstream ss(s);
    string item;
    while (getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}

vector<string> split(const string &s, char delim) {
    	vector<string> elems;
    	split(s, delim, elems);
    	return elems;
}

void eulerMethod(vector< vector<double> > &x, vector< vector<double> > &dx) { 
	// Generate data
	EulerRunTime(x,dx);
}

// Start main program
int main(int argc, char** argv) { 
	for(int i = 0; i < argc ; i++) {
		cout << i << "\t" << argv[i] << endl;
	}

	string filenameAppendage;
	string method = "e"; 

	bool fileCheck = false; 
	for(int i = 0; i < argc ; i++) {
		if(strcmp(argv[i], "-f") == 0 || strcmp(argv[i], "-F") == 0) { 
			fileCheck = true; 
		}
	}
	if(!fileCheck) { 
		cout << "You have not provided a data file, quitting program!" << endl;
		exit(EXIT_FAILURE);
	}

	if(strcmp(argv[1], "-f") != 0 && strcmp(argv[1], "-F") != 0) {
		cout << "Please specify the datafile name first with the flag -f or -F" << endl;
		exit(EXIT_FAILURE);
	}

	for(int i = 0; i < argc ; i++) {
		if(strcmp(argv[i], "-u") == 0 || strcmp(argv[i], "-U") == 0) { 
			if(strcmp(argv[i+1], "0") == 0) { 
				for(int j = 0; j < u.size(); j++) { 
					u[j] = dist(mt)/10;
					filenameAppendage += "u;0;0;0_";
				}
			}
			else {
				// Format (starting u):(length of u to affect):(value to change to)  
				vector<string> exploded = split(argv[i+1], ':');
				for (int i = atoi(exploded[0].c_str()); i < ( atoi(exploded[1].c_str()) + atoi(exploded[0].c_str()) ); i++) { 
					u[i] = atof(exploded[2].c_str());
				}
				filenameAppendage += "u;"+exploded[0]+";"+exploded[1]+";"+exploded[2]+"_";
			}
		}
		else if(strcmp(argv[i], "-r") == 0 || strcmp(argv[i], "-r") == 0) {
			if(strcmp(argv[i+1], "0") == 0) { 
				for(int j = 0; j < r.size(); j++) { 
					r[j] = dist(mt);
					filenameAppendage += "r;0;0;0_";
				}
			}
			else {
				// Format (starting r):(length of r to affect):(value to change to)  
				vector<string> exploded = split(argv[i+1], ':');
				for (int i = atoi(exploded[0].c_str()); i < ( atoi(exploded[1].c_str()) + atoi(exploded[0].c_str()) ); i++) { 
					r[i] = atof(exploded[2].c_str());
				}
				filenameAppendage += "r;"+exploded[0]+";"+exploded[1]+";"+exploded[2]+"_";
			}
		}
		else if(strcmp(argv[i], "-f") == 0 || strcmp(argv[i], "-F") == 0) {
			vector<string> exploded = split(argv[i+1], ':');
			u.push_back(0); 
			r.push_back(atof(exploded[1].c_str()));
			numMutations = atoi(exploded[0].c_str());
			for(int i = 0; i < numMutations; i++) { 
				r.push_back(atof(exploded[1].c_str()));
				u.push_back(atof(exploded[2].c_str()));
			}
			u.push_back(0);
		}
		else if(strcmp(argv[i], "-m") == 0 || strcmp(argv[i], "-M") == 0) {
			method = argv[i+1];
		}
		else if(strcmp(argv[i], "-n") == 0 || strcmp(argv[i], "-N") == 0) {
			N = atof(argv[i+1]);
		}
		else if(strcmp(argv[i], "-t") == 0 || strcmp(argv[i], "-T") == 0) {
			totalTime = atof(argv[i+1]);
		}
	}

	numSteps = totalTime * 10;
	vector<double> d(numMutations+1, 0);
	vector < vector <double> > xa (numSteps+1, d);
	vector < vector <double> > xe (numSteps+1, d);
	vector < vector <double> > master (numSteps+1, d);
	vector < vector <double> > dx (numSteps, d);

	xe[0][0] = N/N; 
	u[0] = 0;
	u[u.size()-1] = 0;

	timeStep = totalTime / numSteps;

	cout << "N: " << N << ", number of mutations: " << numMutations << ", Total Time: " << totalTime << ", number of steps:" << numSteps << endl;
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
	
	if(method == "e") { 

		eulerMethod(xe, dx);
		// Output relevant data to a file
		double displacement = 0, velocity = 0, acceleration = 0, variance = 0, Ex = 0, Ex2 = 0;
		string outfile = "temp.txt";
		string binfile = "temp.bin";
		ofstream myfile (outfile);
		ofstream binfiles (binfile);
		myfile << "Time" << "\t" << "Displacement" << "\t" << "R" << "\t" << "U" << "\t" << "Velocity" << "\t" << "Acceleration" << "\t" << "Variance" << "\t" << "Label" << endl;
		for(int j = 0; j < numSteps - 1; j++) {
			displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
			binfiles << timeStep*j << "\t";
			for(int k = 0; k < (numMutations+1); k++) { 
				displacement += xe[j][k]*k;
				velocity += ( xe[j+1][k]*k - xe[j][k]*k )/timeStep; 
				Ex += xe[j][k]*k;
				Ex2 += xe[j][k]*k*k; 
				acceleration += ( ( xe[j+2][k]*k - xe[j+1][k]*k )/timeStep - ( xe[j+1][k]*k - xe[j][k]*k )/timeStep ) / timeStep;
				binfiles << xe[j][k] << "\t";
			}
			binfiles << "\n";
			variance = pow(Ex2 - pow(Ex,2), 0.5);
			myfile << timeStep*j << "\t" << displacement << "\t" << r[round(displacement)] << "\t" << u[round(displacement)] << "\t" << velocity << "\t" << acceleration << "\t" << variance << "\t" << "e"+filenameAppendage << "\n"; 
		}
		myfile.close();
	
	}

	return 0; 
}