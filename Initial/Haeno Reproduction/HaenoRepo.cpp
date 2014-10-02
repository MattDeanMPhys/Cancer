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
const double u1 = 0.1;
const double u2 = 0.1;
const bool debug = false; 
const double max_reac = 100;
//const double max_reac = 10000;
double r[3] = {1,1,1}; 
double n[3] = {0,0,0};
double r1; 
double r2; 
//######################################## 

// Define a decent random number generator
auto s = chrono::high_resolution_clock::now().time_since_epoch().count();
mt19937 mt(s);
uniform_real_distribution<double> dist(0,1);

// Generate transition rates
void gen_trans_rate(vector<double> &transr) { 
	//cout << "Generating rates...." << endl; 
	double rbar = ( (r[0]*n[0]) + (r[1]*n[1]) + (r[2]*n[2]) ) / N;
	//cout << "rbar: " << rbar << endl; 
	transr[0] = ( (1-u1)*r[0]*n[0]*n[1]/N ) / (rbar);
	transr[1] = ( (1-u1)*r[0]*n[0]*n[2]/N ) / (rbar);
	transr[2] = ( ( u1*r[0]*n[0]/N ) + ( (1-u2)*r[1]*n[1]/N ) ) * n[0] / rbar;
	transr[3] = ( ( u1*r[0]*n[0]/N ) + ( (1-u2)*r[1]*n[1]/N ) ) * n[2] / rbar;
	transr[4] = ( ( u2*r[1]*n[1]/N ) + ( r[2]*n[2]/N ) ) * n[0] / rbar;
	transr[5] = ( ( u2*r[1]*n[1]/N ) + ( r[2]*n[2]/N ) ) * n[1] / rbar;

	if(transr[0] <= 0 || transr[1] <= 0 || transr[2] <= 0 || transr[3] <= 0 || transr[4] <= 0 || transr [5] <= 0) { 
		//cout << "One of the transition rates is <= 0!!!" << endl;
	}
	if(debug) {
		cout << "Trans rates: " << transr[0] << "\t" << transr[1] << "\t" << transr[2] << "\t" << transr[3] << "\t" << transr[4] << "\t" << transr[5] << endl; 
	}
}

// Fixation test
bool fixation_test() { 
	if(n[2] == N) {return false;}
	else {return true;}
}

//Produce time of fixation
double run_time() { 
	n[0] = N; n[1] = 0; n[2] = 0;
	
	if(debug) {
		cout << "n0 ,n1, n2:" << n[0] <<"," << n[1] << "," << n[2] << endl; 
	}
	
	double t = 0;
	bool progress = true; 
	//bool fixation = true; 
	//while(fixation) { 

	//for(int j=0; j<max_reac; j++) { 

	while(progress) {
		vector<double> tr(6,0);
		double a0=0, delta=0;
		int mu = 0;  

		r1 = dist(mt);
		r2 = dist(mt); 

		gen_trans_rate(tr); 

		if(debug) {
			cout << "r1, r2:" << r1 << "," << r2 << endl;
		} 

		for(vector<double>::iterator it = tr.begin() ; it != tr.end(); ++it) { 
			a0 += (*it); 
		}	

		if(debug) {
			cout << "a0: " << a0 << endl;
		}

		delta = (1/a0)*log(1/r1); 

		// Increment time after reaction
		if((t+=delta) > max_reac) {
			 progress = false; 
			 t -= delta; 
		} 
		else { 
			// Find mu given that sum_j=1^mu-1 < r2*a0 <= sum_j=1^mu
			for(int k=6; k != 0; k--) { 
				double s1=0, s2=0;

				for (int l = 0; l < k; l++) {
					s2 += tr[l];
				}

				for (int y = 0; y < (k-1); y++) {
					s1 += tr[y];
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

			switch(mu) { 
				case 1: 
					n[1]--; n[0]++;
					break;
				case 2: 
					n[2]--; n[0]++; 
					break;
				case 3: 
					n[0]--; n[1]++;
					break;
				case 4: 
					n[2]--; n[1]++; 
					break;
				case 5: 
					n[0]--; n[2]++;
					break;
				case 6:
					n[1]--; n[2]++;
					break;
				default: 
					break;
			}
		//fixation = fixation_test();  
		}
	}
	return t; 
}

int main(int argc, char** argv) { 
	cout << "changing r2 to 1.0 now!" << endl; 

	ofstream myfile ("aaaaaaaaaaa.txt");

	double max_m = 10 ;
	double min_r = 0.1 ;
	double max_r = 3 ;
	double step = (max_r - min_r)/max_m ;
	
	
	for(int m = 0; m < max_m; m++){
		
		double ft = 0, dummy = 0; 
		double fix_count = 0; 
		int p;
			
		r[1] = min_r + step*m;
 
		cout << "Starting test for r1 = " << r[1] << endl;

		for(p = 0; p < 1000; p++) {
			dummy = run_time(); 
			//cout << "Run time: " << dummy << endl;
			//if(p%10000 == 0) { 
			//	cout << "At iteration: " << p << endl; 
			//}
			if(n[2] == N) { fix_count++; }
		}

		ft = fix_count/p; 

		if(myfile.is_open()) { 
			myfile << r[1] << "\t" << ft << endl; 
		}		
		else cout << "Unable to open file" << endl; 
	}

	myfile.close();

	return 0; 
}
