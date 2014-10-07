#include <iostream>
#include "Rates.h"
#include "Population.h"
#include <vector>

int main(){


Population pop_t(3,10);


auto n = pop_t.Get_Population();

pop_t.Print_Population();

std::vector<double> r = {1,1,1};

std::vector<double> u = {0,0.1,0.1,0};

Rates rates_t(n,r,u);

rates_t.Print_Rates();

rates_t.Print_Vars();

return 0;

}
