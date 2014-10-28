#include <iostream> 
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>

using namespace std; 

/* ----------- Define Constants ----------- */
int numMutations = 99;
double totalTime = 3000; 
int numSteps = totalTime * 10; 
double timeStep;
double N = 10000;
double t = 0;

vector<double> y(numMutations+1, 0);
vector <double> r (numMutations+1,1); 
vector <vector <double>> x (numSteps+1, y);
//vector <vector <double>> x (numMutations+1,0);
vector <double> u (numMutations+2,0.1);
vector <vector <double>> dx (numSteps, y);

/* ---------------------------------------- */

double generateConcentrationRate(int i, int j, double rbar) { 
	double concentrationRate;
	if((i-1) < 0) { 
		 concentrationRate = ( ( ( ( 1 - u[i+1] )*r[i] - rbar )*x[j][i] ) ) / rbar; 
	}
	else { 
		concentrationRate = ( ( u[i]*r[i-1]*x[j][i-1] ) + ( ( ( 1 - u[i+1] )*r[i] - rbar )*x[j][i] ) ) / rbar; 
 	} 
	return concentrationRate; 
}

int main(int argc, char** argv) { 

	x[0][0] = N/N; 
	u[0] = 0;
	u[u.size()-1] = 0;
	
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
	
	double dumdum = 0;

	ofstream velfile ("U_"+to_string(numMutations)+"_mutationrate"+"_0-001_vel"+".txt");
	for(int z = 0; z < u.size(); z++) { 
		t = 0;
		for(int y = 0; y < u.size(); y++) { 
			u[y] = 0.1;
		}
		
		if(z%20 == 0) {
		u[z] = 0.001;
		u[0] = 0; 
		u[u.size()-1] = 0;
			//ofstream myfile ("U_"+to_string(numMutations)+"_mutationrate_"+to_string(z)+".txt");
			//double dumdum = 0;
			for(int j = 0; j < numSteps; j++) { 
				for(int l = 0; l < (numMutations+1); l++) { 
					rbar += r[l]*x[j][l];
				}

				for(int k = 0; k < (numMutations+1); k++) { 
					dx[j][k] = generateConcentrationRate(k, j, rbar);
				}

				for(int m = 0; m < (numMutations+1); m++) { 
					x[j+1][m] = x[j][m] + timeStep*dx[j][m];
				}

				//dumdum = 0; 
				//for(int k = 0; k < (numMutations+1); k++) { 
				//	 dumdum += x[j][k]*k;
				//}
				//myfile << dumdum << "," << t << endl;

				t += timeStep; 
				rbar = 0;

				if(j%(numSteps/10) == 0) { 
					cout << j << endl;
				}
			}
			
			//ofstream velfile ("U_"+to_string(numMutations)+"_mutationrate_"+to_string(z)+"_vel"+".txt");
			//for(int y = 0; y < u.size(); y++) { 
			//	velfile << u[y] << ",";
			//} 
			//velfile << "\n";

			double sum1=0, sum2=0, dumdum2 = 0;
			for(int j = 0; j < numSteps-1; j++) {
				sum1=0; sum2=0;
				for(int k = 0; k < (numMutations+1); k++) { 
					 sum1 += x[j][k]*k;
					 sum2 += x[j+1][k]*k; 
				}
				velfile << j*timeStep << "\t" << sum1 << "\t" << (sum2 - sum1)/timeStep << "\t" << "l_"+to_string(z) << endl;
			}
		}
	}

	cout << "Final time: " << t << endl;
	return 0; 
}