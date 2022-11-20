#!/bin/bash
rm index.html
git rev-parse remotes/origin/main >> hash1.txt
diff hash1.txt ./main/hash.txt > /dev/null 2>&1
error=$? 
if [ $error -eq 1 ]
then
num1=$(git log -1 --pretty="format:%ct" ./main)
num2=$(git log Deployment..main -1 --pretty="format:%ct" ./main)
if ["$num2" -gt "$num1"]
then 
rm -rf ./main/
git checkout remotes/origin/main -- main
cd ./main
bash buildwebsite.sh
rm hash.txt
git rev-parse remotes/origin/main >> hash.txt
cd ..
fi
fi
git rev-parse remotes/origin/Experimental >> hash2.txt
diff hash2.txt ./Experimental/hash.txt > /dev/null 2>&1
error=$?
if [ $error -eq 1 ]
then
num1=$(git log -1 --pretty="format:%ct" ./Experimental)
num2=$(git log Deployment..Experimental -1 --pretty="format:%ct" ./Experimental)
if ["$num2" -gt "$num1"]
then
rm -rf ./Experimental/
git checkout remotes/origin/Experimental --  Experimental
cd ./Experimental
bash buildwebsite.sh
rm hash.txt
git rev-parse remotes/origin/Experimental >> hash.txt
cd ..
fi
fi
gfortran homepage.f90
./a.out >> index.html
rm a.out hash1.txt hash2.txt list.txt num.txt
