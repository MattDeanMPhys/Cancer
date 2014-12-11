#! /bin/bash

RUN='ANTITRAPGRAPH4'

CELLS=1000
MUTS=50
ITS=30
RFLAT=1
UFLAT=0.1
RLAND="ANTITRAP"
RTRAP=0.95
RTRAPSTART=20
RTRAPEND=30

UTRAP=0.1
UTRAPSTART=10
UTRAPEND=10
ULAND="FLAT"

sed -e "s/{{CELLS}}/$CELLS/; \
 	s/{{MUTS}}/$MUTS/;
	s/{{ITS}}/$ITS/;
	s/{{RFLAT}}/$RFLAT/;
	s/{{UFLAT}}/$UFLAT/;
	s/{{RLAND}}/$RLAND/;
	s/{{ULAND}}/$ULAND/;
	s/{{RTRAP}}/$RTRAP/; 
	s/{{RTRAPSTART}}/$RTRAPSTART/;
	s/{{RTRAPEND}}/$RTRAPEND/;
	s/{{UTRAP}}/$UTRAP/; 
	s/{{UTRAPSTART}}/$UTRAPSTART/;
	s/{{UTRAPEND}}/$UTRAPEND/" simulation_template.cpp > simulation_replaced.cpp

g++ simulation_replaced.cpp Population.cpp Rates.cpp -o run$RUN -std=c++11

rm simulation_replaced.cpp

