#include <iostream> 
#include <vector> 
#include <chrono>
#include <random> 
#include <cmath>
#include <string>
#include <fstream>

using namespace std; 
int x = 200, y = 3;
int numberMutations = 3; 

int main() { 
	double dummy[x][y]; 
	double master[x][y]; 
	for(int i = 0; i < x; i++) { 
		for(int j = 0; j < y; j++) { 
			master[i][j] = 0;
		}
	}

	double t; 
	int count = 0; 
	int numExpt = 0;
	int row, col = 0;
	ifstream infile ("input.txt");

	if(infile.is_open()) { 
		while (!infile.eof()) {
			infile >> t; 
			if(t == 99999) { 
				count = 0;
				row = 0; 
				col = 0;
				cout << "Dummy" << endl;
				for(int i = 0; i < x; i++) { 
					for(int j = 0; j < y; j++) { 
						master[i][j] += dummy[i][j];
					}
				}
				numExpt++;
			}
			else { 
				cout << "Row: " << row << " Col: " << col << " Count: " << count << endl;
				dummy[row][col] = t;
				cout << t << endl;
				++col;
				++count;
				if(count%numberMutations == 0) { 
					++row; 
					col = 0;
				}
			}
		}
	}
	else {
		cout << "Cannot open file OMG!!" << endl;
	}
	cout << "numExpt: " << numExpt << endl;

	for(int i = 0; i < x; i++) { 
		for(int j = 0; j < y; j++) { 
			master[i][j] = master[i][j]/numExpt;
		}
	}

	ofstream outfile ("output.txt");
	for(int i = 0; i < x; i++) { 
		for(int j = 0; j < y; j++) { 
			outfile << master[i][j] << ",";
		}
		outfile << "\n";
	}
	

	return 0;
}