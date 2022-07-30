#!/bin/bash
echo
mem=`free -mh| grep "Mem:"| fmt -u| cut -d " " -f 2`
echo $mem
read -p "請按任意鍵盤繼續"
