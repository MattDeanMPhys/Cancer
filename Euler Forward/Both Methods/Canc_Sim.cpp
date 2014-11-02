#include <iostream>
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>
#include <vector> 
#include <stdlib.h>

using namespace std; 

//########### Define Global Variables ###########
double N = 10000; 
double numberMutations = 9;  
double numberSteps = 300;
double totalTime = 300;
int averageNumber = 100;
double rStart = 1.0, rEnd = 1.0, rSteps = 1;


vector<double> r (numberMutations+1,1);
vector<double> n (numberMutations+1,0);
vector<double> u (numberMutations+2,0.1);

double r1; 
double r2; 

//######################################## 

// Define a decent random number generator
auto s = chrono::high_resolution_clock::now().time_since_epoch().count();
mt19937 mt(s);
uniform_real_distribution<double> dist(0,1);

//Generate general transition rates 
double generateTransRate(int j, int i, double rbar) { 
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

void resetVariables() { 

	n[0] = N; 

	for(int k = 1; k <= numberMutations; k++)	{ 
		n[k]=0;
	}	

}

void runTime(vector< vector<double> > & vec) { 

	resetVariables();

	int dim = numberMutations+1;

	vector<double> v(dim,0);
	vector< vector<double> > transitionRate (dim, v);

	double t = 0, tnext = 0, tdum = 0, ntr = numberMutations*( ( 2 ) + ( numberMutations-1 ) ), a0 = 0, delta = 0, rb = 0;  
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
					transitionRate[row][col] = generateTransRate(row,col,rb);
					a0 += transitionRate[row][col];
				}	 
			}
		}

		delta = (1/a0)*log(1/r1);
		tdum = t + delta; 

		if(tdum > tnext) { 
			for(int i = 0; i < n.size(); i++) { 
				vec[record][i] = n[i];
			}	
			vec[record][n.size()] = tnext;
			++record; 
			tnext += totalTime/numberSteps;
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
			 

		if(record == numberSteps) { 
			progress = false;
		}
		//cout << "time: " << t << endl;
	}
}

int main(int argc, char** argv) { 
	
	vector<double> y((n.size()+1),0);
	vector< vector<double> > dummy (numberSteps, y);
	vector< vector<double> > master (numberSteps, y);
	double fixate = 0;

	ofstream outfile ("output_"+to_string(N)+"_"+to_string(numberMutations)+"_"+to_string(totalTime)+"_"+to_string(averageNumber)+".txt");
	
	for(int j = 0; j < rSteps; j++) {
		r[1] = rStart + j*( (rEnd - rStart) / rSteps);
		fixate = 0;
		for(int a = 0; a < averageNumber; a++) { 
			
			for(int row = 0; row < numberSteps; row++){
				for(int col = 0; col < n.size()+1; col++) { 
					dummy[row][col] = 0;
				}
			}

			runTime(dummy);

			if(dummy[numberSteps-1][n.size()-1] == N) { fixate++; }

			for(int row = 0; row < numberSteps; row++){
				for(int col = 0; col < n.size()+1; col++) { 
					master[row][col] += dummy[row][col];
				}
			}
		}

		//outfile << r[1] << "\t" << fixate/averageNumber << "\n";
	}

	for(int row = 0; row < numberSteps; row++){
		for(int col = 0; col < n.size()+1; col++) { 
			master[row][col] = master[row][col]/averageNumber;
		}	
	}

	for(int row = 0; row < numberSteps; row++){
		for(int col = 0; col < n.size()+1; col++) { 
			cout << master[row][col] << ", ";
		}	
		cout << "\n";
	}	

	double summate; 

	for(int row = 0; row < numberSteps; row++){
		for(int col = 0; col < n.size(); col++) { 
			summate += master[row][col]*col;
		}	
		outfile << summate << "\t" << master[row][n.size()] << "\n";
	}		

	outfile.close();

	return 0; 
}