	
			// Find mu given that sum_j=1^mu-1 < r2*a0 <= sum_j=1^mu
			double sum = 0;
			int mu = 0;
			bool cont = true;
			int row=0, col=0;
			double limit = r1*a0; 

			while(cont) {
				if( (sum += tr_new[row][col]) > limit ) { 
					mu = (row+1)+(col*dim);
					cout << "Mu: " << mu << endl;
					cont = false;
				}
				cout << "Sum: " << sum << endl;
				cout << row << "\t" << col << endl;

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