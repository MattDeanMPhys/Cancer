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

//Generate general transition rates 
double generateTransRate(vector<double> &n, int j, int i, double rbar) { 
	double tr;
	if((i-1) < 0) { 
		tr = ( ( 1-u[i+1] )*r[i]*( n[i]/N )*n[j] / rbar );
	}
	else { 
		tr = ( ( u[i]*r[i-1]*( n[i-1]/N ) )+( ( 1-u[i+1] )*r[i]*( n[i]/N ) ) ) * n[j] / rbar;
	} 
	return tr; 
}

// Function to find Mu
int calculateMu (vector< vector<double> > &vec, double r2, double a0, int dim) { 
	// Find mu given that sum_j=1^mu-1 < r2*a0 <= sum_j=1^mu
	double sum = 0;
	int mu = 0;
	bool cont = true;
	int row=0, col=0;
	double limit = r2*a0; 

	while(cont) {
		if( (sum += vec[row][col]) > limit ) { 
			mu = (row+1)+(col*dim);
			cont = false;
		}

		++row;		
		if(row%dim == 0) { 
			++col;
			row = 0; 
		}
	}
	return mu;
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

void AverageRunTime(vector< vector<double> > &vec) { 
	
	vector<double> n (numMutations+1,0); 
	n[0] = N; 
	for(int k = 1; k <= numMutations; k++)	{ 
		n[k]=0;
	}	

	double r1; 
	double r2; 
	
	int dim = numMutations+1;

	vector<double> v(dim,0);
	vector< vector<double> > transitionRate (dim, v);

	double t = 0, tnext = 0, tdum = 0, ntr = numMutations*( ( 2 ) + ( numMutations-1 ) ), a0 = 0, delta = 0, rb = 0;  
	int record = 0, mu = 0;
	bool progress = true;
	
	while(progress) { 

		for(int i = 0; i < dim; i++) { 
			for(int j = 0; j < dim; j++) { 
				transitionRate[i][j] = 0;
			}
		}

		a0 = 0; 
		delta = 0;

		r1 = dist(mt); 
		r2 = dist(mt);

		rb = 0;
		for(int k = 0; k < dim; k++) { 
			rb += (r[k]*n[k]);
		}
		rb = rb / N;

		for(int row = 0; row < dim; row++) { 
			for(int col = 0; col < dim; col++) { 
				if(row == col) { transitionRate[row][col] = 0; }
				else { 
					transitionRate[row][col] = generateTransRate(n,row,col,rb);
					a0 += transitionRate[row][col];
				}	 
			}
		}

		delta = (1/a0)*log(1/r1);
		tdum = t + delta; 

		if(tdum > tnext) { 
			for(int i = 0; i < (numMutations+1); i++) { 
				vec[record][i] = n[i];
			}	
			++record; 
			tnext += totalTime/numSteps;
		}

		if(n[n.size()-1] == N) { 
			t += 0;
			//cout << "reached fixation" << endl;
		}
		else { 

			t += delta;

			mu = calculateMu(transitionRate, r2, a0, dim);

			//cout << "mu: " << mu << endl;

			int counter = 0; 
			for(int col = 0; col < dim; col++) { 
				for(int row = 0; row < dim; row++) {  
					++counter; 
					if(counter == mu) { 
						n[row]--; n[col]++; 
					}
				}
			}

		}
			 
		if(record == numSteps) { 
			progress = false;
		}
		//cout << "time: " << t << endl;
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

	myfile << "library(ggplot2)\n" << "library(gtable)\n" << "rm(list=ls())\n" << "data = read.csv(\u0027"+outfile+"\u0027, sep = \u0027\\t\u0027 , header=T)\n";
	myfile << "graphDisplacement = ggplot(data, aes(Time, Displacement, col=Label)) + geom_line(aes(linetype=Label), size = 0.5) \n"; 
	myfile << "scale_linetype_manual(values=c(\u0027dotdash\u0027, \u0027dotted\u0027)) \n";
	myfile << "graphVelocity = ggplot(data, aes(Time, Velocity, col=Label)) + geom_line( se=F)\n";
	myfile << "graphAcceleration = ggplot(data, aes(Time, Acceleration, col=Label)) + geom_line()\n";
	myfile << "graphVariance = ggplot(data, aes(Time, Variance, col=Label)) + geom_line()\n"; 
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

void eulerMethod(vector< vector<double> > &x, vector< vector<double> > &dx) { 
	// Generate data
	EulerRunTime(x,dx);
}

void averageMethod(vector< vector<double> > &dummy, vector< vector<double> > &master) { 

	for(int a = 0; a < averageNumber; a++) { 
		
		for(int row = 0; row < numSteps+1; row++){
			for(int col = 0; col < (numMutations+1); col++) { 
				dummy[row][col] = 0;
			}
		}

		AverageRunTime(dummy);

		for(int row = 0; row < numSteps+1; row++){
			for(int col = 0; col < (numMutations+1); col++) { 
				master[row][col] += dummy[row][col];
			}
		}
	}

	for(int row = 0; row < (numSteps+1); row++){
		for(int col = 0; col < (numMutations+1); col++) { 
			master[row][col] = master[row][col]/averageNumber;
		}	
	}

}

// Start main program
int main(int argc, char** argv) { 
	for(int i = 0; i < argc ; i++) {
		cout << i << "\t" << argv[i] << endl;
	}

	string filenameAppendage;
	string method = "e"; 
	string customName = "";

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
					r[i] = stod(exploded[2]);
				}
				filenameAppendage += "r;"+exploded[0]+";"+exploded[1]+";"+exploded[2]+"_";
			}
		}
		else if(strcmp(argv[i], "-f") == 0 || strcmp(argv[i], "-F") == 0) {
			readData(argv[i+1]);
		}
		else if(strcmp(argv[i], "-m") == 0 || strcmp(argv[i], "-M") == 0) {
			method = argv[i+1];
		}
		else if(strcmp(argv[i], "-o") == 0 || strcmp(argv[i], "-O") == 0) {
			customName = argv[i+1];
		}
	}

	numSteps = totalTime * 10;
	vector<double> d(numMutations+1, 0);
	vector < vector <double> > xa (numSteps+1, d);
	vector < vector <double> > xe (numSteps+1, d);
	vector < vector <double> > master (numSteps+1, d);
	vector < vector <double> > dx (numSteps, d);

	xa[0][0] = N;
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
	
	if(method == "a") { 
		averageMethod(xa, master);
		// Output relevant data to a file
		double displacement = 0, velocity = 0, acceleration = 0, variance = 0, Ex = 0, Ex2 = 0;
		string outfile = "Avgfile_"+to_string(N)+"_"+to_string(totalTime)+"_"+to_string(numMutations+1)+"_"+filenameAppendage+"input_"+argv[2]+".txt";
		ofstream myfile (outfile);
		ofstream testf ("test.txt");
		myfile << "Time" << "\t" << "Displacement" << "\t" << "Velocity" << "\t" << "Acceleration" << "\t" << "Variance" << "\t" << "Label" << endl;
		for(int j = 0; j < numSteps - 1; j++) {
			displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
			for(int k = 0; k < (numMutations+1); k++) { 
				displacement += master[j][k]*k/N;
				velocity += ( master[j+1][k]*k/N - master[j][k]*k/N )/timeStep; 
				Ex += master[j][k]*k/N;
				Ex2 += master[j][k]*k*k/N; 
				acceleration += ( ( master[j+2][k]*k/N - master[j+1][k]*k/N )/timeStep - ( master[j+1][k]*k/N - master[j][k]*k/N )/timeStep ) / timeStep;
			}
			variance = Ex2 - pow(Ex,2);
			myfile << timeStep*j << "\t" << displacement << "\t" << velocity << "\t" << acceleration << "\t" << variance << "\t" << "a" << "\n"; 
			//for(int l = 0; l < (numMutations+1); l++) { 
			//	myfile << x[j][l] << ","; 
			//}
			//myfile << "\n";
			for(int l = 0; l < (numMutations+1); l++) { 
				testf << master[j][l] << ","; 
			}
			testf << "\n";
		}

		plotR(outfile, argv[2], N, totalTime, numMutations, filenameAppendage);
	}

	else if(method == "e") { 
		eulerMethod(xe, dx);
		// Output relevant data to a file
		double displacement = 0, velocity = 0, acceleration = 0, variance = 0, Ex = 0, Ex2 = 0;
		string outfile;
		if(customName!="") { 
			outfile = "Eulfile_"+customName+".txt";
		}
		else { 
			outfile = "Eulfile_"+to_string(N)+"_"+to_string(totalTime)+"_"+to_string(numMutations+1)+"_"+filenameAppendage+"input_"+argv[2]+".txt";
		}
		
		ofstream myfile(outfile, ios::out | ios::app);

		if(customName!="") {

			int rowTrigger = 0;
			int j = 0;
			while(j < numSteps+1) { 
				if(xe[j][numMutations] > 0.999) { 
					rowTrigger = j;
					j = numSteps;
				}
				j++;
			}
			
			cout << "rowTrigger: " << rowTrigger << endl;

			myfile << "Mutations" << "\t" << "Fixation" << "\t" << "UStart" << "\t" << "UEnd" << "\t" << "UValue" << "\t" << "RStart" << "\t" << "REnd" << "\t" << "RValue" << endl;
			myfile << numMutations+1 << "\t" << rowTrigger*timeStep << "\t";
			
			bool trap; 
			for(int i = 0; i < argc ; i++) {
				if(strcmp(argv[i], "-u") == 0 || strcmp(argv[i], "-U") == 0) { 
						trap = true;
						vector<string> exploded = split(argv[i+1], ':');
						// Format (starting u):(length of u to affect):(value to change to)  
						myfile << exploded[0] << "\t" << stod(exploded[0]) + (stod(exploded[1])-1) << "\t" << exploded[2] << "\t" << "0" << "\t" << "0" << "\t" << to_string(r[1]);

				}
				else if(strcmp(argv[i], "-r") == 0 || strcmp(argv[i], "-r") == 0) {
						trap = true;
						// Format (starting r):(length of r to affect):(value to change to)  
						vector<string> exploded = split(argv[i+1], ':');
						// Format (starting u):(length of u to affect):(value to change to)  
						myfile << "0" << "\t" << "0" << "\t" << to_string(u[1]) << "\t" << exploded[0] << "\t" << stod(exploded[0]) + (stod(exploded[1])-1) << "\t" << exploded[2];
				}
			}
			if(!trap) { 
				myfile << "0" << "\t" << "0" << "\t" << to_string(u[1]) << "\t" << "0" << "\t" << "0" << "\t" << to_string(r[1]);
			}
			myfile << "\n";
		}
		else { 

			myfile << "Time" << "\t" << "Displacement" << "\t" << "Velocity" << "\t" << "Acceleration" << "\t" << "Variance" << "\t" << "Label" << endl;
			for(int j = 0; j < numSteps - 1; j++) {
				displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
				for(int k = 0; k < (numMutations+1); k++) { 
					displacement += xe[j][k]*k;
					velocity += ( xe[j+1][k]*k - xe[j][k]*k )/timeStep; 
					Ex += xe[j][k]*k;
					Ex2 += xe[j][k]*k*k; 
					acceleration += ( ( xe[j+2][k]*k - xe[j+1][k]*k )/timeStep - ( xe[j+1][k]*k - xe[j][k]*k )/timeStep ) / timeStep;
				}
				variance = Ex2 - pow(Ex,2);
				myfile << timeStep*j << "\t" << displacement << "\t" << velocity << "\t" << acceleration << "\t" << variance << "\t" << "e" << "\n"; 
			}

			plotR(outfile, argv[2], N, totalTime, numMutations, filenameAppendage);
		
		}
	}

	else if(method == "b") {
		cout << "Starting averaging method..." << endl; 
		averageMethod(xa, master);
		cout << "Starting Euler method..." << endl;
		eulerMethod(xe, dx);

		double displacement = 0, velocity = 0, acceleration = 0, variance = 0, Ex = 0, Ex2 = 0;
		string outfile = "Combofile_"+to_string(N)+"_"+to_string(totalTime)+"_"+to_string(numMutations+1)+"_"+filenameAppendage+"input_"+argv[2]+".txt";
		ofstream myfile (outfile);
		myfile << "Time" << "\t" << "Displacement" << "\t" << "Velocity" << "\t" << "Acceleration" << "\t" << "Variance" << "\t" << "Label" << endl;
		for(int j = 0; j < numSteps - 1; j++) {
			displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
			for(int k = 0; k < (numMutations+1); k++) { 
				displacement += xe[j][k]*k;
				velocity += ( xe[j+1][k]*k - xe[j][k]*k )/timeStep; 
				Ex += xe[j][k]*k;
				Ex2 += xe[j][k]*k*k; 
				acceleration += ( ( xe[j+2][k]*k - xe[j+1][k]*k )/timeStep - ( xe[j+1][k]*k - xe[j][k]*k )/timeStep ) / timeStep;
			}
			variance = Ex2 - pow(Ex,2);
			myfile << timeStep*j << "\t" << displacement << "\t" << velocity << "\t" << acceleration << "\t" << variance << "\t" << "e" << "\n"; 
		}
		displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
		for(int j = 0; j < numSteps - 1; j++) {
			displacement = 0; velocity = 0; acceleration = 0; variance = 0, Ex = 0, Ex2 = 0;
			for(int k = 0; k < (numMutations+1); k++) { 
				displacement += master[j][k]*k/N;
				velocity += ( master[j+1][k]*k/N - master[j][k]*k/N )/timeStep; 
				Ex += master[j][k]*k/N;
				Ex2 += master[j][k]*k*k/N; 
				acceleration += ( ( master[j+2][k]*k/N - master[j+1][k]*k/N )/timeStep - ( master[j+1][k]*k/N - master[j][k]*k/N )/timeStep ) / timeStep;
			}
			variance = Ex2 - pow(Ex,2);
			myfile << timeStep*j << "\t" << displacement << "\t" << velocity << "\t" << acceleration << "\t" << variance << "\t" << "a" << "\n"; 
		}

		plotR(outfile, argv[2], N, totalTime, numMutations, filenameAppendage);
	}

	return 0; 
}