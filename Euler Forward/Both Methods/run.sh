#!/bin/bash
echo "Starting Bash"
for i in ten.txt twenty.txt thirty.txt forty.txt fifty.txt sixty.txt seventy.txt eighty.txt ninety.txt hundred.txt
do 
	for j in 0 20 40 60 80
		do
		for k in 0 20 40 60 80	
		do		
			for l in 10 20 
			do
				./Both_mod -f $i -m e -u $j:$l:0.01 -r $k:$l:0.5 -o param_var
			done
		done
	done
done
