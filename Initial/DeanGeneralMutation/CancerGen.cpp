#include <iostream>
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>

using namespace std; 

//########### Define Global Variables ###########
double N; 
double number_mutations; 
const bool debug = false; 
double max_reac;
double r_start; 
double r_end; 
double steps; 
double avg; 

vector<double> r; 
vector<double> n = {0,0,0};
vector<double> u;  
double r1; 
double r2; 
//######################################## 

// Define a decent random number generator
auto s = chrono::high_resolution_clock::now().time_since_epoch().count();
mt19937 mt(s);
uniform_real_distribution<double> dist(0,1);

//Generate general transition rates 
double gen_trans_rate_new(int j, int i, double rbar) { 
	double tr;
	if ((i-1) < 0) { 
		tr = ( ( 1-u[i+1] )*r[i]*( n[i]/N )*n[j] / rbar );
	}
	else { 
		tr = ( ( u[i]*r[i-1]*( n[i-1]/N ) )+( ( 1-u[i+1] )*r[i]*( n[i]/N ) ) ) * n[j] / rbar;
	} 
	return tr; 
}

// Fixation test
bool fixation_test() { 
	if(n[2] == N) {return false;}
	else {return true;}
}


// Read in values 
void read_data(string file) { 

	ifstream myReadFile;
 	myReadFile.open(file);
 	
 	int line=0; 
 	double r_dum, u_dum, N_dum, max_reac_dum, r_start_dum, r_end_dum, steps_dum, avg_dum;
 
 	cout << "Reading in data...." << endl;

 	if (myReadFile.is_open()) {
 		myReadFile >> N_dum >> max_reac_dum >> r_start_dum >> r_end_dum >> steps_dum >> avg_dum;
  	}

  	cout << "Constant variables have been read in...." << endl;

  	N = N_dum;
	max_reac = max_reac_dum;
 	r_start = r_start_dum;
	r_end = r_end_dum;
	steps = steps_dum;
	avg = avg_dum;

  	cout << N_dum << "\t" << max_reac_dum<< "\t" << r_start_dum<< "\t" << r_end_dum<< "\t" << steps_dum<< "\t" << avg_dum << endl;
  	cout << N << "\t" << max_reac<< "\t" << r_start<< "\t" << r_end<< "\t" << steps<< "\t" << avg<< endl;

 	if (myReadFile.is_open()) {
 		while (!myReadFile.eof()) {
 				myReadFile >> r_dum >> u_dum; 
 				if (debug) { 
 					cout << r_dum << "," << u_dum << endl;
 				}

 				r.push_back(r_dum); 
 				u.push_back(u_dum); 
 				line++;
 		}
	}

	cout << "Finished reading in u's and r's" << endl;

	number_mutations = line; 
	u.push_back(0);

	myReadFile.close();

	if (debug) { 
		cout << "Number of mutations: " << line << endl; 
		for(int k = 0; k < line; k++) { 
			cout << "(N,r,u): " << k << "," << r[k] << "," << u[k] << endl;
		}
	}
}


//Produce time of fixation
double run_time() { 

	n.clear();
	n.push_back(N);

	for (int k = 0; k < (number_mutations-1); k++)	{ 
		n.push_back(0);
	}
	
	if(debug) {
		cout << "n0 ,n1, n2:" << n[0] <<"," << n[1] << "," << n[2] << endl; 
	}
	
	double t = 0;
	bool progress = true; 
	
	while (progress) {

		int dim = number_mutations+1; 
		
		cout << n[0] << "\t" << n[1]  << "\t" << n[2] << endl;

		if (n[2] ==10) {
			return 0;
		}

		// Total number of transition rates
		double ntr = number_mutations*( ( 2 ) + ( number_mutations-1 ) );
		
		double tr_new[dim][dim]; 

		for (int row = 0; row < dim; row++) { 
			for (int col = 0; col < dim; col++) { 
				tr_new[row][col] = 0;
			}
		}


		double a0=0, delta=0;
		int mu = 0;  

		r1 = dist(mt);
		r2 = dist(mt); 

		double rb = 0; 

		for (int k = 0; k < dim; k++) { 
			rb += (r[k]*n[k]);
		}

		rb = rb / N;

		for (int row = 0; row < dim; row++) { 
			for (int col = 0; col < dim; col++) { 
				if (row == col) {
				}
				else { 
					tr_new[row][col] = gen_trans_rate_new(row,col,rb);
					a0 += tr_new[row][col];
				}	 
			}
		}
		

		if (debug) {
			cout << "r1, r2:" << r1 << "," << r2 << endl;
		} 	

		if (debug) {
			cout << "a0: " << a0 << endl;
		}

		delta = (1/a0)*log(1/r1); 

		// Increment time after reaction
		
		if ((t+=delta) > max_reac) {
			 progress = false; 
			 t -= delta; 
		} 
		
		else { 
			// Find mu given that sum_j=1^mu-1 < r2*a0 <= sum_j=1^mu
			for (int k=ntr; k != 0; k--) { 
				double s1=0, s2=0;
				int l = 1, y = 1; 
				
				for (int col = 0; col < dim; col++) { 
					for (int row = 0; row < dim; row++) { 
						if (y <= (k-1)) {	
							if (row == col) { 
						 	}
							else { 
								s1 += tr_new[row][col];
								y++;
							}
						}	 
						else { 
							break; 
						}
					}
				}

				for (int col = 0; col < dim; col++) { 
					for (int row = 0; row < dim; row++) { 
						if (l <= k) {	
							if (row == col) {  
							}
							else { 
								s2 += tr_new[row][col];
								l++;
							}
						}
						else {
							break;
						}	 
					}
				}

				if(debug) {
					cout << "s1:" << s1 << "\t" << "s2:" << s2 << "r2 a0:" << r2*a0 << endl;
				}

				bool s1t = s1 < (r2*a0);
				bool s2t = (r2*a0) <= s2;

				if(s1t) { 
					if(s2t) { 
						mu = k; 
						if(debug) {
							cout << "k:" << k << endl;
						}
					}
				}
			}

			if(debug) {
				cout << "mu: " << mu << endl;
			}

			int counter = 0; 

			for (int col = 0; col < dim; col++) { 
				for (int row = 0; row < dim; row++) { 
					if (row == col) {  }
					else { 
						++counter; 
						if (counter == mu) { 
							n[row]--; n[col]++;
						}
					}
				}	 
			}
		}
	}
	return t; 
}

int main(int argc, char** argv) {
 
	string file;
 
	if (argc != 2) {
		cout << "Too many arguments, program exiting!" << endl;
		 exit(0);
	}
	else { 
		file = argv[1];
	} 

	read_data(file);

	ofstream myfile ("data_"+file+".txt");
/*
	for (int m = 0; m < steps; m++){

		double ft = 0, dummy = 0; 
		double fix_count = 0; 
		int p;

		r[1] = r_start + ((r_end- r_start)/steps)*m; 

		cout << "Starting test for r1 = " << r[1] << endl;

		for (p = 0; p < avg; p++) {

			dummy = run_time();
 
			if(p%10000 == 0) { 
				cout << "At iteration: " << p << endl; 
			}

			if(n[2] == N) {
			 	fix_count++; 
			}
		}

		ft = fix_count/p; 

		if (myfile.is_open()) { 
			myfile << r[1] << "\t" << ft << endl; 
		}		
		else cout << "Unable to open file" << endl; 
	}
*/


	double simulation = run_time();

	myfile.close();


	return 0; 
}
