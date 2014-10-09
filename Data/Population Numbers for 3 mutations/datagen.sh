#!/bin/bash

> Bigfile.txt

for i in `seq 1 10`

do

	./Simulation >> "$i".txt

	cat "$i".txt >> Bigfile.txt
done 
