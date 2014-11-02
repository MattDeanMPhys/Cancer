#include <iostream> 
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>
#include <sstream>
#include <stdlib.h>

using namespace std; 

class 

/* ----------- Define Constants ----------- */
int numMutations;
double totalTime; 
int numSteps; 
double timeStep;
double N;
double t = 0;

//vector <double> r (numMutations+1,1); 
//vector <double> u (numMutations+2,0.1);

vector <double> r;
vector <double> u;

/* ---------------------------------------- */

// Define a decent random number generator
auto s = chrono::high_resolution_clock::now().time_since_epoch().count();
mt19937 mt(s);
uniform_real_distribution<double> dist(0,1);

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
void runTime(vector< vector<double> > &x, vector< vector<double> > &dx) { 
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

// Read in data from specified file
void readData(string file) { 
	ifstream myReadFile;
 	myReadFile.open(file);

	if (myReadFile.is_open()){

	 	int line=0; 
	 	double r_dum, u_dum, N_dum, totalTime_dum, numSteps_dum; 
	 	cout << "Reading in data...." << endl;
	 	if (myReadFile.is_open()) {
	 		myReadFile >> N_dum >> totalTime_dum;
	  	}
	  	cout << "constants have been read in as...." << endl;
	  	totalTime = totalTime_dum; N = N_dum;
	  	cout << "Total time: " <<  totalTime << "\t Number of cells: " << N << endl;
	 	if (myReadFile.is_open()) {
	 		while (!myReadFile.eof()) {
	 				myReadFile >> r_dum >> u_dum; 
	 				r.push_back(r_dum); 
	 				u.push_back(u_dum); 
	 				line++;
	 		}
		}

		cout << "variables have been read in..." << endl;

		numMutations = (line-1); 
		u.push_back(0);

		myReadFile.close();

	}
	else { 
		cout << "File " << file << " does not exist, quitting program!" << endl;
		exit(EXIT_FAILURE);
	}
}

void plotR(string outfile, string filename, double N, double totalTime, double numMutations, string filenameAppendage) { 

	string rfile = "outfile_"+to_string(N)+"_"+to_string(totalTime)+"_"+to_string(numMutations+1)+"_"+filenameAppendage+"input_"+filename+"_Rplot.r";
	cout << rfile << endl;
	ofstream myfile (rfile);

	myfile << "library(ggplot2)\n" << "library(gtable)\n" << "rm(list=ls())\n" << "data = read.csv(\u0027"+outfile+"\u0027, sep = \u0027\\t\u0027 )\n";
	myfile << "graphDisplacement = ggplot(data, aes(Time, Displacement)) + geom_line() \n"; 
	myfile << "graphVelocity = ggplot(data, aes(Time, Velocity)) + geom_line( se=F)\n";
	myfile << "graphAcceleration = ggplot(data, aes(Time, Acceleration)) + geom_line()\n";
	myfile << "graphVariance = ggplot(data, aes(Time, Variance)) + geom_line()\n"; 
	myfile << "grphD = ggplotGrob(graphDisplacement)\n";
	myfile << "grphVel = ggplotGrob(graphVelocity)\n";
	myfile << "grphAccel = ggplotGrob(graphAcceleration)\n";
	myfile << "grphVar = ggplotGrob(graphVariance)\n";
	myfile << "g = gtable:::rbind_gtable(grphD, grphVel, \u0027first\u0027 )\n"; 
	myfile << "h = gtable:::rbind_gtable(g, grphAccel, \u0027first\u0027 )\n"; 
	myfile << "f = gtable:::rbind_gtable(h, grphVar, \u0027first\u0027 )\n"; 
	myfile << "grid.newpage()\n" << "grid.draw(f)\n";

	stringstream ss;

    ss << "Rscript " << "\"" << rfile << "\""; 
    cout << ss.str().c_str() << endl;
    system(ss.str().c_str());
}

// Start main program
int main(int argc, char** argv) { 
	for(int i = 0; i < argc ; i++) {
		cout << i << "\t" << argv[i] << endl;
	}

	string filenameAppendage; 

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
				}
			}
			else {
				// Format (starting u):(length of u to affect):(value to change to)  
				vector<string> exploded = split(argv[i+1], ':');
				for (int i = stoi(exploded[0]); i < ( stoi(exploded[1]) + stoi(exploded[0]) ); i++) { 
					u[i] = stod(exploded[2]);
				}
				filenameAppendage += "u;"+exploded[0]+";"+exploded[1]+";"+exploded[2]+"_";
			}
		}
		else if(strcmp(argv[i], "-r") == 0 || strcmp(argv[i], "-r") == 0) {
			if(strcmp(argv[i+1], "0") == 0) { 
				for(int j = 0; j < r.size(); j++) { 
					r[j] = dist(mt);
				}
			}
			else {
				// Format (starting r):(length of r to affect):(value to change to)  
				vector<string> exploded = split(argv[i+1], ':');
				for (int i = stoi(exploded[0]); i < ( stoi(exploded[1]) + stoi(exploded[0]) ); i++) { 
					r[i] = stoi(exploded[2]);
				}
				filenameAppendage += "r;"+exploded[0]+";"+exploded[1]+";"+exploded[2]+"_";
			}
		}
		else if(strcmp(argv[i], "-f") == 0 || strcmp(argv[i], "-F") == 0) {
			readData(argv[i+1]);
		}
	}

	numSteps = totalTime * 10;
	vector<double> d(numMutations+1, 0);
	vector < vector <double> > x (numSteps+1, d);
	vector < vector <double> > dx (numSteps, d);

	x[0][0] = N/N; 
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
	
	// Generate data
	runTime(x,dx);

	// Output relevant data to a file
	double displacement = 0, velocity = 0, acceleration = 0, variance = 0, Ex = 0, Ex2 = 0;
	string outfile = "outfile_"+to_string(N)+"_"+to_string(totalTime)+"_"+to_string(numMutations+1)+"_"+filenameAppendage+"input_"+argv[2];
	ofstream myfile (outfile);
	myfile << "Time" << "\t" << "Displacement" << "\t" << "Velocity" << "\t" << "Acceleration" << "\t" << "Variance" << "\t" << "Populations" << endl;
	for(int j = 0; j < numSteps - 1; j++) {
		displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
		for(int k = 0; k < (numMutations+1); k++) { 
			displacement += x[j][k]*k;
			velocity += ( x[j+1][k]*k - x[j][k]*k )/timeStep; 
			Ex += x[j][k]*k;
			Ex2 += x[j][k]*k*k; 
			acceleration += ( ( x[j+2][k]*k - x[j+1][k]*k )/timeStep - ( x[j+1][k]*k - x[j][k]*k )/timeStep ) / timeStep;
		}
		variance = Ex2 - pow(Ex,2);
		myfile << timeStep*j << "\t" << displacement << "\t" << velocity << "\t" << acceleration << "\t" << variance << "\n"; 
		//for(int l = 0; l < (numMutations+1); l++) { 
		//	myfile << x[j][l] << ","; 
		//}
		//myfile << "\n";
	}

	ofstream datfile ("test.txt");
	for(int j = 0; j < numSteps; j++) {
		for(int k = 0; k < (numMutations+1); k++) { 
			datfile << x[j][k] << ","; 
		}
		datfile << "\n";
	}	

	plotR(outfile, argv[2], N, totalTime, numMutations, filenameAppendage);

	return 0; 
}