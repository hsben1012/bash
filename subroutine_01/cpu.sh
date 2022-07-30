#!/bin/bash
echo
cpu=` cat /proc/cpuinfo | grep "model name" | sort -u | cut -d ":" -f 2`
echo $cpu
read -p "請按任意鍵繼續"
