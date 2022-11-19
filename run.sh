#!/bin/bash
git rev-parse remotes/origin/main >> hash.txt
diff hash.txt ./main/hash.txt > /dev/null 2>&1
error=$? 
if [ $error -eq 1 ]
then
rm -rf ./main/
git checkout remotes/origin/main -- main
cd ./main
bash buildwebsite.sh
mv ../hash.txt .
cd ..
fi

git rev-parse remotes/origin/Experimental >> hash.txt
diff hash.txt ./Experimental/hash.txt > /dev/null 2>&1
error=$?
if [ $error -eq 1 ]
then
rm -rf ./Experimental/
git checkout remotes/origin/Experimental --  Experimental
cd ./Experimental
bash buildwebsite.sh
mv ../hash.txt .
cd ..
fi
gfortran homepage.f90
./a.out >> index.html
rm a.out index.html list.txt num.txt hash.txt
