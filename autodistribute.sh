#!/bin/bash
#判斷是否有輸入參數
[ $# == "0" ] && echo 'Please input file name U want to distribute.[tar file name;node no. start;node no. end]' && exit

for ((count=${2};count<=${3};count=count+1))
do

  #判斷目的地是否有FileFromM1資料夾 沒有就建
  ssh w${count} [ -d "/home/bigred/FileFromM1" ] && ssh w${count} [ $? == "1" ] && ssh w${count} "mkdir FileFromM1"
  #SCP file到目的地
  scp $1 bigred@w${count}:/home/bigred/FileFromM1 && echo w${count} node scp ok!
  #Load image到worker node並刪除SCP過去的檔案
  ssh w${count} "sudo podman load < FileFromM1/$1 &>/dev/null" && ssh w${count} "rm FileFromM1/$1" && echo w${count} node ok!

done