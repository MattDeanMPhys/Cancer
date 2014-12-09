Deans Diary
===

25/09/14
---

Today we implemented the Gilespie alogrithm in an attempt to replicate the [Manchester paper](https://github.com/MattDeanMPhys/Cancer/Papers/AshcroftMichorGalla.pdf) data. 

It looks like we've managed to get the initial implementation done, getting a good stochastic graph from the changes in population. 

But the magnitude of numbers don't match as we vary r1. This is either down to our algorithm implementation or just the general coding. 

We have enough to present to Galla, i.e. the animated bar chart and the stochastic graph. My plan for the weekend is to get them looking nicer and in standalone form. 

02/10/14
---

Today we have succesfully reporduced the graphs in the Haeno paper, using the exact same parameters, this shows that our code is working. 
We also generalised the program to take in N types of mutations and just starting to analyse the data that will come from that. 

07/10/14
---

Refactored the code using classes. The bare bones basic complied version is working. Need to fully write the simulation to finnish off the refactoring work and make sure that it performs as exepected. Main troubles will be passing the object between each other.


09/10/14
---

Finished refactoring. Euler forward done aswell. Ready to test it against the simulated data. Then from induction can see that simulation is good. 

14/10/14
---

Stochastic average needed to go through and match up the correct times with the correct population numbers. 

16/10/14
---

Singlularly varrying the individual fitness values for each cell type in a 10 type set up .

21/10/14
---

Adding the variacne into the statistics function for the population calculations etc. 

23/10/14
---

Beginning the analytic equation stuff


28/10/14
---

Looking at traps and antitraps for various set ups. Making sure graphs are aligned. 

30/10/14
---

Started building the app and got most of it done. 

04/11/14
---

Polished the app up completly to show Gallas. 


06/11/14
---

Analytic equations updated again. Arrived at the master equation. Derrived the PDE. 

11/11/14
---

More polish of the app. 

13/11/14
---

Initial Poissonian attempts and Fourier and solving. 

18/11/14
---

Continuing on the Fourier mucking about looking  at constraints etc. 

20/11/14
---

More fourier. 


25/11/14
---

More Fourier. 

27/11/14
---

Added in the initial condition of the Fourier to see if that got us closer to the correct result. 
Now have to solutions, one more general and one using the fact that the first bin decays exponentially. 

Calculated the ratios of the of Euler forward and Fourier solution. The old result is converging to a constant factor of out. The new version is diverging away. So more info is needed. 

02/12/14
---
Fixed the Fourier normalisation (added a 1/2pi to our solution. This fixed the discrepancy of roughly 6 observed between the Euler solution and the Fourier analytic equation. In addition we have started to reformat graphs we have produced, ready for the report. 

04/12/14
—s
Another day spent tidying up graphs for the report. Additionally, we tried to see if the Fourier analytic solution could be averaged to get the same results as Euler average. 







