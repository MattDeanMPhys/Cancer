#! /bin/bash

for f in *.tex
do
	pdflatex $f
#	read -p "Press [Enter] key to start backup..."
done

#for g in *.pdf
#	convert -density 600x600 $g -quality 90 $g.png
#done
