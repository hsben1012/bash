#!/bin/bash
echo
disk=`df -mh | grep "/dev/sda2" | fmt -u | cut -d " " -f 2`
echo $disk
read -p "請按任意鍵繼續"
