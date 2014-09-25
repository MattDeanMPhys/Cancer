#include <iostream>
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>

using namespace std; 

//########### Define Constants ###########
static const double N = 10; 
static const double iter = 10;
static const double u1 = 0.1;
static const double u2 = 0.1;
double r[3] = {1,2,1}; 
double n[3] = {0,0,0};
double r1; 
double r2; 
double t = 0;
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
	cout << "Trans rates: " << transr[0] << "\t" << transr[1] << "\t" << transr[2] << "\t" << transr[3] << "\t" << transr[4] << "\t" << transr[5] << endl; 
}

int main() { 

	vector<double> tr (6,0); 
	//vector<*cell> cells;  

	//for(int i=0; i < N; i++) { 
	//	cells.push_back(new cell);
	//}

	n[0] = N; 

	for(int j = 0; j < iter; j++) {  
		double a0 = 0, delta = 0, s1 = 0, s2 = 0; 
		int mu = 0; 
 
 		//cout << "About to gen rates..." << endl; 
		gen_trans_rate(tr); 
 
		r1 = dist(mt);
		r2 = dist(mt);

		//cout << "Random Numbers: " << r1 << ", " << r2 << endl; 
		
		for(vector<double>::iterator it = tr.begin() ; it != tr.end(); ++it) { 
			a0 += (*it); 
		}

		delta = (1/a0)*log(1/r1); 



	//Dean's Algorithm for finding mu
	cout << "Entering Dean's Algo" << endl; 
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

		cout << small_sum << " " << target << " " << big_sum << endl;

		bool big_sum_test = target <= big_sum ;
		bool small_sum_test = target > small_sum ;

		if (big_sum_test) {
			if (small_sum_test) {
				cout << "Dean's mu: " << mu_dean << endl;
				mu = mu_dean;
				break;
			}
		}

		mu_dean--;
	}

	cout << "Exciting  Dean's Algo" << endl; 
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
		if (n[0]*n[1]*n[2] < 0 ) {
			return 0;
		}
		cout << "Population: " << n[0] << ", " << n[1] << ", " << n[2] << endl; 
	}

	return 0; 
}
