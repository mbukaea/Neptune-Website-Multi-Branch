#!/bin/bash
git checkout main -- main
cd ./main
bash buildwebsite.sh
cd ..
git checkout Experimental --  Experimental
cd Experimental
bash buildwebsite.sh
cd ..
cp ./main/sans-serif-lwarp-sagebrush.css ./
gfortran-mp-12 homepage.f90
./a.out >> index.html
