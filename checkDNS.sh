#!/bin/bash
[ $# == "0" ] && echo 'Please input DNS Domain name U want to check.' && exit
while true
do
  dig @8.8.8.8 ns ${1} | grep ${2}
    if [ $? == "0" ];then
      break
    else
      continue
    fi
done
echo "End"
