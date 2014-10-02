double find_mu(transmissions, double random_2) {

	int mu;
	double small_sum = 0 ;
	double big_sum = 0;
	bool small_sum_test = 0;
	bool big_sum_test = 0;

	double a0;

	int transmissions_rows = sizeof(transmissions)/sizeof(transmissions[0]);

	for (int i =0; i < transmissions_rows; i++) {
		for (int j = 0; j < transmissions_rows; j++) {

			a0 = a0 + transmissions[i][j];
		}
	}
	
	int test_mu = 1;

	for (int i = 0; i < transmissions_row ; i++) {
		for (int j=0; j < transmissions_row; j++) {

			small_sum = big_sum;

			big_sum += transmissions[i][j]

			small_sum_test = small_sum < random_2 * a0 ;
			big_sum_test = big_sum >= random_2 * a0 ;

			if (small_sum_test && big_sum_test) {
				return test_mu;
			}
			else{
				test_mu ++;
			}
		}

 	}

	return 0;

		

			
}
