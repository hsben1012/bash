#!/bin/bash
name=`hostname`
cpu=` cat /proc/cpuinfo | grep "model name" | sort -u | cut -d ":" -f 2`
mem=`free -mh| grep "Mem:"| fmt -u| cut -d " " -f 2`
disk=`df -mh | grep "/dev/sda2" | fmt -u | cut -d " " -f 2`
echo "主機名稱: "$name
echo "CPU型號: "$cpu
echo "RAM容量: "$mem
echo "硬碟大小: "$disk

