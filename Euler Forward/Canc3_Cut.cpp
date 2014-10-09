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
double num_mutations;  
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
	if((i-1) < 0) { 
		tr = ( ( 1-u[i+1] )*r[i]*( n[i]/N )*n[j] / rbar );
	}
	else { 
		tr = ( ( u[i]*r[i-1]*( n[i-1]/N ) )+( ( 1-u[i+1] )*r[i]*( n[i]/N ) ) ) * n[j] / rbar;
	} 
	return tr; 
}

// Fixation test
bool fixation_test() { 
	if(n[num_mutations] == N) {return true;}
	else {return false;}
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
  	cout << "constant variables have been read in...." << endl;
  	N = N_dum; max_reac = max_reac_dum; r_start = r_start_dum; r_end = r_end_dum; steps = steps_dum; avg = avg_dum;
  	cout << N_dum << "\t" << max_reac_dum<< "\t" << r_start_dum<< "\t" << r_end_dum<< "\t" << steps_dum<< "\t" << avg_dum << endl;
  	cout << N << "\t" << max_reac<< "\t" << r_start<< "\t" << r_end<< "\t" << steps<< "\t" << avg<< endl;
 	if (myReadFile.is_open()) {
 		while (!myReadFile.eof()) {
 				myReadFile >> r_dum >> u_dum; 
 				r.push_back(r_dum); 
 				u.push_back(u_dum); 
 				line++;
 		}
	}

	cout << "finished reading in u's and r's" << endl;

	num_mutations = (line-1); 
	u.push_back(0);

	n.clear();
	for(int k = 0; k < line; k++) { 
		n.push_back(0);
	}

	myReadFile.close();
}


//Produce time of fixation
double run_time() { 
	
	ofstream myfile ("data.txt");

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
	
	n[0] = N; 

	for(int k = 1; k <= num_mutations; k++)	{ 
		n[k]=0;
	}

	double t = 0;
	bool progress = true; 

	//bool fixation = true; 
	//while(fixation) { 

	//for(int j=0; j<max_reac; j++) { 
	int s = 0;
	while(progress) {
		if(myfile.is_open()) { 
			for(int i = 0; i < n.size(); i++) { 
				myfile << n[i] << ", "; 	
			}
			myfile << t << endl;
		}		
		else cout << "Unable to open file" << endl; 

		int dim = num_mutations+1; 
		
		// Total number of transition rates
		double ntr = num_mutations*( ( 2 ) + ( num_mutations-1 ) );

		double tr_new[dim][dim]; 

		double a0=0, delta=0;
		int mu = 0;  

		r1 = dist(mt);
		r2 = dist(mt); 

		double rb = 0; 
		for(int k = 0; k < dim; k++) { 
			rb += (r[k]*n[k]);
		}
		rb = rb / N;

		for(int row = 0; row < dim; row++) { 
			for(int col = 0; col < dim; col++) { 
				if(row == col) { tr_new[row][col] = 0; }
				else { 
					tr_new[row][col] = gen_trans_rate_new(row,col,rb);
					a0 += tr_new[row][col];
				}	 
			}
		}

		delta = (1/a0)*log(1/r1); 

		/*
		for(int row = 0; row < dim; row++) { 
			for(int col = 0; col < dim; col++) { 
				cout << tr_new[row][col] << ", ";
			}
			cout << "\n";
		}
		cout << "\n";
		*/

		// Increment time after reaction
		
		/*
		if((t+=delta) > max_reac) {
			 progress = false; 
			 t -= delta; 
		} 
		*/

		t+=delta; 
		if(false) { }
		else { 
			
			// Find mu given that sum_j=1^mu-1 < r2*a0 <= sum_j=1^mu
			double sum = 0;
			int mu = 0;
			bool cont = true;
			int row=0, col=0;
			double limit = r2*a0; 

			while(cont) {
				if( (sum += tr_new[row][col]) > limit ) { 
					mu = (row+1)+(col*dim);
					cont = false;
				}

				++row;		
				if(row%dim == 0) { 
					++col;
					row = 0; 
				}
			}
			
			int counter = 0; 
			for(int col = 0; col < dim; col++) { 
				for(int row = 0; row < dim; row++) {  
					++counter; 
					if(counter == mu) { 
						n[row]--; n[col]++; 
					}
				}
			}	 
		//fixation = fixation_test();  
		}

		//if(fixation_test()) { 
		//	cout << "Final State: " << endl; 
		//	for(int z = 0; z < n.size(); z++) { 
		//		cout << n[z] << ", "; 
		//	}
		//	cout << "\n";
		//	progress = false;
		//}
 		++s;
 		if(s == max_reac) { 
 			progress = false;
 		} 

	}
	return t; 
}

int main(int argc, char** argv) { 
	string file; 
	if(argc != 2) {cout << "Too many arguments, program exiting!" << endl; exit(0); }
	else { file = argv[1]; } 

	read_data(file);
	double dummy[][];

	cout << "Starting runtime: " << endl;
	for(int w = 0; w < 2*pow(10,3); w++) { 
		double dummy = run_time();

	}
	

	/*
	ofstream myfile ("data_"+file+".txt");
	
	for(int m = 0; m < steps; m++){
		double ft = 0, dummy = 0; 
		double fix_count = 0; 
		int p;
		r[1] = r_start + ((r_end- r_start)/steps)*m; 
		cout << "Starting test for r1 = " << r[1] << endl;

		for(p = 0; p < avg; p++) {
			dummy = run_time(); 
			//cout << "Run time: " << dummy << endl;
			if(p%10000 == 0) { 
				cout << "At iteration: " << p << endl; 
			}
			if(n[2] == N) { fix_count++; }
		}

		ft = fix_count/p; 

		if(myfile.is_open()) { 
			myfile << r[1] << "\t" << ft << endl; 
		}		
		else cout << "Unable to open file" << endl; 
	}
	
	myfile.close();
	*/

	return 0; 
}
