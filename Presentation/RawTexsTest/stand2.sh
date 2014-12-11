#! /bin/bash


for f in *.tex
do
	echo $f

	cat StartOfFile.txt >> "STANDALONE$f"
	cat $f >> "STANDALONE$f"
	cat EndOfFile.txt >> "STANDALONE$f"


done
