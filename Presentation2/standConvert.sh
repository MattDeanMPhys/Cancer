#! /bin/bash

for f in *.tex
do
	pdflatex $f
done

for g in *.pdf

	convert -density 600x600 $g -quality 90 $g.png
done
