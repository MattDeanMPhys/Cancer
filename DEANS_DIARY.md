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

Refactored the code using classes. The bare bones basic complied version is working. Need to fully write the simulation to finnish off the refactoring work and make sure that it performs as exepected. Main troubles will be passing the object between each other:
