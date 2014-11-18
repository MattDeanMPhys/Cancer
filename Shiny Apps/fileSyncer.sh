#! /bin/bash

rm *.txt

ls Animator | grep \.txt$ >> AnimatorFileList.txt
ls ../Data/shinyData  | grep \.txt$ >> shinyDataFileList.txt
ls StatsVis  | grep \.txt$ >> StatsVisFileList.txt
