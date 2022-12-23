#!/bin/bash
[ $# == "0" ] && echo 'Please input DNS domain name & key word U want to check. [./checkDNS.sh domain_name key_word]' && exit
while true
do
  dig @8.8.8.8 ns ${1} | grep ${2}
    if [ $? == "0" ];then #if found then break
      break
    else
      continue #if not found then continue
    fi
done
echo "End"
