#!/bin/bash

for i in `seq 0 9`;
do

	./r$i &
done	
wait


