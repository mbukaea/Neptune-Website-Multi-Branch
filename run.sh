#!/bin/bash
git rev-parse remotes/origin/main >> hash.txt
diff hash.txt ./main/hash.txt > /dev/null 2>&1
error=$? 
if [ $error -eq 1 ]
then
rm -rf ./main/
git checkout main -- main
cd ./main
bash buildwebsite.sh
cd ..
rm hash.txt
fi

git rev-parse remotes/origin/Experimental >> hash.txt
diff hash.txt ./Experimental/hash.txt > /dev/null 2>&1
error=$?
if [ $error -eq 1 ]
then
rm -rf ./Experimental/
git checkout Experimental --  Experimental
cd ./Experimental
bash buildwebsite.sh
cd ..
rm hash.txt
fi

cp ./main/sans-serif-lwarp-sagebrush.css ./
gfortran homepage.f90
./a.out >> index.html
