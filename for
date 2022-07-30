#!/bin/bash
#for c in would you marry john
for c in $1 $2 $3 $4
do
 echo $c
 sleep 1
done
echo $0 #show filename
echo $* #show you input variable
echo $# #show the account you input variable
