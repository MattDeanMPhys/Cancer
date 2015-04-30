#! /bin/bash


for f in *.tex
do
	echo $f

	cat StartOfFile.txt >> "./Figures/STANDALONE$f"
	cat $f >> "./Figures/STANDALONE$f"
	cat EndOfFile.txt >> "./Figures/STANDALONE$f"


done
