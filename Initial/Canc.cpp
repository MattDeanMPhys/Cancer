#include <iostream>
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
<<<<<<< HEAD
#include <string>
#include <fstream>
=======
>>>>>>> FETCH_HEAD

using namespace std; 

//########### Define Constants ###########
static const double N = 10; 
<<<<<<< HEAD
=======
static const double iter = 10000;
>>>>>>> FETCH_HEAD
static const double u1 = 0.01;
static const double u2 = 0.01;
double r[3] = {1,2,1}; 
double n[3] = {0,0,0};
double r1; 
double r2; 
//######################################## 

class cell { 
	protected: 
		int mutations; 
	private: 
		cell () {mutations = 0;}
		cell (int m) {mutations = m;}
};

auto s = chrono::high_resolution_clock::now().time_since_epoch().count();
mt19937 mt(s);
uniform_real_distribution<double> dist(0,1);

void gen_trans_rate(vector<double> &transr) { 
	//cout << "Generating rates...." << endl; 
	double rbar = ( r[0]*n[0] + r[1]*n[1] + r[2]*n[2] ) / N;
	//cout << "rbar: " << rbar << endl; 
	transr[0] = ( (1-u1)*r[0]*n[0]*n[1] ) / (N * rbar);
	transr[1] = ( (1-u1)*r[0]*n[0]*n[2] ) / (N * rbar);
	transr[2] = ( ( u1*r[0]*n[0]/N ) + ( (1-u2)*r[1]*n[1]/N ) ) * n[0] / rbar;
	transr[3] = ( ( u1*r[0]*n[0]/N ) + ( (1-u2)*r[1]*n[1]/N ) ) * n[2] / rbar;
	transr[4] = ( ( u2*r[1]*n[1]/N ) + ( r[2]*n[2]/N ) ) * n[0] / rbar;
	transr[5] = ( ( u2*r[1]*n[1]/N ) + ( r[2]*n[2]/N ) ) * n[1] / rbar;
	//cout << "Trans rates: " << transr[0] << "\t" << transr[1] << "\t" << transr[2] << "\t" << transr[3] << "\t" << transr[4] << "\t" << transr[5] << endl; 
}

bool fixation_test() { 
	if(n[2] == N) {return true;}
	else {return false;}
}

double run_time() { 

	vector<double> tr (6,0); 
	n[0] = N; n[1] = 0; n[2] = 0;
	double t = 0; 

<<<<<<< HEAD
	int j = 0;
	bool fixation = false;  
	while(!fixation) {
	//for(int j = 0; j < iter; j++) {  
		double a0 = 0, delta = 0, s1 = 0, s2 = 0; 
		int mu; 
		int mu_tmp = 6; 
=======
	n[0] = N; 

	for(int j = 0; j < iter; j++) {  
		double a0 = 0, delta = 0, s1 = 0, s2 = 0; 
		int mu = 0; 
>>>>>>> FETCH_HEAD
 
 		//cout << "About to gen rates..." << endl; 
		gen_trans_rate(tr); 
 
		r1 = dist(mt);
		r2 = dist(mt);

		//cout << "Random Numbers: " << r1 << ", " << r2 << endl; 
		
		for(vector<double>::iterator it = tr.begin() ; it != tr.end(); ++it) { 
			a0 += (*it); 
		}

		delta = (1/a0)*log(1/r1); 

<<<<<<< HEAD
		while (mu_tmp != 0) {

			double big_sum = 0;
			double small_sum = 0;

				for (int k = 0; k < mu_tmp; k++) {
					big_sum += tr[k];
				}

				for (int k = 0; k < (mu_tmp-1); k++) {
					small_sum += tr[k];
				}

				//cout << small_sum << " " << (r2*a0) << " " << big_sum << endl;
=======


	//Dean's Algorithm for finding mu
	//cout << "Entering Dean's Algo" << endl; 
	double target = r2*a0 ;
	int mu_dean = 6 ;
	while (mu_dean != 0) {

	double big_sum = 0;
	double small_sum = 0;
		//sum the array 

		for (int k = 0; k < mu_dean; k++) {

			big_sum += tr[k];

		}

		for (int k = 0; k < mu_dean-1; k++) {

			small_sum += tr[k];

		}


		//small_sum = big_sum - tr[mu] ; 

		//cout << small_sum << " " << target << " " << big_sum << endl;
>>>>>>> FETCH_HEAD

		bool big_sum_test = target <= big_sum ;
		bool small_sum_test = target > small_sum ;

<<<<<<< HEAD
				if (big_sum_test) {
					if (small_sum_test) {
						//cout << "Dean's mu: " << mu_tmp << endl;
						mu = mu_tmp;
						break;
					}
				}
				mu_tmp--;
=======
		if (big_sum_test) {
			if (small_sum_test) {
				//cout << "Dean's mu: " << mu_dean << endl;
				mu = mu_dean;
				break;
			}
>>>>>>> FETCH_HEAD
		}

		mu_dean--;
	}

	//cout << "Exciting  Dean's Algo" << endl; 
	//Dean's algorithm end
	mu = mu_dean;	
	t += delta; 

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
<<<<<<< HEAD

		fixation = fixation_test();  
		j++;
	}
	cout << n[2] << endl; 
	return t; 
}

int main(int argc, char** argv) { 
	ofstream myfile ("data.txt");
	for(int m = 0; m < 11; m++){
		double fix_time = 0; 
		r[1] = 1 + 0.02*m; 
		for(int l = 0; l < (5*pow(10.0, 3.0)); l++) { 
			fix_time += run_time(); 
		}
		fix_time = fix_time / (5*pow(10.0, 3.0)); 
		if (myfile.is_open()) {
			myfile << r[1] << "\t" << fix_time << endl; 
		}
		else cout << "Unable to open file";
=======
		if (n[2]==10 ) {
		cout << j << endl;
			return 0;
		}
		cout << n[0] << ", " << n[1] << ", " << n[2] << endl; 
>>>>>>> FETCH_HEAD
	}

	myfile.close();
	return 0; 
}
