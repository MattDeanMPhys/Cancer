rm(list=ls())
library(grid)
library(ggplot2)
library(tikzDevice)

data = read.csv("160641483882148_FixationTimes.txt", head = F)
