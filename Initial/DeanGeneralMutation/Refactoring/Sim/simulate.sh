#!/bin/bash
rm simulation
g++ simulation.cpp Population.cpp Rates.cpp -o simulation -std=c++11 
./simulation

