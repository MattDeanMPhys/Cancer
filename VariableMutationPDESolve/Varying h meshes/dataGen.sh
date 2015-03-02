#!/bin/bash

for i in {0..10}
	do
		deltaX=$(echo 0.05 + $i*0.005 | bc -l)
		#echo "$deltaX"
		echo "$deltaX" | julia PDESolve.jl &
	done


