#!/bin/bash

for i in {1..20}
	do
		deltaX=$(echo $i/200 | bc -l)
		echo "$deltaX" | julia PDESolve.jl &
	done


