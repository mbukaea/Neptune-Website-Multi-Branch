#!/bin/bash
rm index.html
git rev-parse remotes/origin/main >> hash1.txt
diff hash1.txt ./main/hash.txt > /dev/null 2>&1
error=$? 
if [ $error -eq 1 ]
then
rm -rf ./main/
git checkout remotes/origin/main -- main
cd ./main
bash buildwebsite.sh
rm hash.txt
git rev-parse remotes/origin/main >> hash.txt
cd ..
fi

git rev-parse remotes/origin/Experimental >> hash2.txt
diff hash2.txt ./Experimental/hash.txt > /dev/null 2>&1
error=$?
if [ $error -eq 1 ]
then
rm -rf ./Experimental/
git checkout remotes/origin/Experimental --  Experimental
cd ./Experimental
bash buildwebsite.sh
rm hash.txt
git rev-parse remotes/origin/Experimental >> hash.txt
cd ..
fi
gfortran homepage.f90
./a.out >> index.html
rm a.out hash1.txt hash2.txt list.txt num.txt
