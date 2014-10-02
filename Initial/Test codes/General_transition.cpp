#include <iostream>
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>

using namespace std; 

//########### Define Constants ###########
const double N = 10; 
const bool debug = false; 
const double max_reac = 100;
//const double max_reac = 10000;
vector<double> u; 
vector<double> r; 
vector<double> n;
double r1; 
double r2; 
//######################################## 

int main(int argc, char *argv[]) { 
	string file; 
	if(argc > 2) {cout << "Too many arguments, program exiting!"; exit(0); }
	else { file = argv[1];  }

	ifstream myReadFile;
 	myReadFile.open(file);
 	
 	int line=0; 
 	double r_dum, u_dum; 
 	cout << "Reading in: " << endl;
 	if (myReadFile.is_open()) {
 		while (!myReadFile.eof()) {
 				myReadFile >> r_dum >> u_dum; 
 				cout << r_dum << "," << u_dum << endl;
 				r.push_back(r_dum); 
 				u.push_back(u_dum); 
 				line++;
 		}
	}
	n.push_back(line); 

	for(int k = 0; k < (line-1); k++)	{ 
		n.push_back(0);
	}

	myReadFile.close();

	cout << "Number of mutations: " << line << endl; 
	for(int k = 0; k < line; k++) { 
		cout << "(N,r,u): " << k << "," << r[k] << "," << u[k] << endl;
	}

}