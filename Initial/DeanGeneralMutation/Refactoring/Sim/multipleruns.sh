#!/bin/bash

for i in `seq 1 5`

do 

	./simulation >> "$i".txt
done
