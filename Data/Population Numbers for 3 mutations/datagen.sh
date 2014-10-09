#!/bin/bash

> Bigfile.txt

for i in `seq 1 100`

do

	./Simulation >> "$i".txt

	cat "$i".txt >> Bigfile.txt
	rm "$i".txt
done 
