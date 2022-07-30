#!/bin/bash

# 檢查參數
[ "$#" -lt "1" ] && echo "pls choose cp / reboot / j8 ,thx !" && exit 1

# 宣告變數
a="dta1"
s="dts1 dts2 dts3"
m="dtm1 dtm2"
w="dtw1 dtw2 dtw3 dtw4 dtw5 dtw6"

# 檢查 DT 內網
for n in $a $s $m $w
do
  if ! nc -w 1 -z "$n" 22 &>/dev/null; then
    echo "注意，無法連線 $n !" && exit 1
  fi
done


# 拷貝 ~/vmusdt 目錄, 重新開機, 確認 openjdk-8-jdk, 確認內網
case $1 in

cp)
  for n in $a $s $m $w
  do
    if ssh "$n" ls -l | grep vmusdt >/dev/null; then
      echo "$n vmusdt already exist !"
    else
      scp -r vmusdt bigboss@"$n":/home/bigboss/ &>/dev/null && echo "$n vmusdt ok"
    fi
  done
;;

reboot)
  for n in $w $m $s $a
  do
    ssh "$n" sudo reboot
  done
;;

j8)
  for n in $a $s $m $w
  do
    if ! ssh "$n" java -version check &>/dev/null; then
      ssh "$n" sudo apt-get install  openjdk-8-jdk &>/dev/null
      echo "$n"
      ssh "$n" java -version check
    else
      echo "$n"
      ssh "$n" java -version check
    fi
  done
;;

net)
  for n in $a $s $m $w
  do
    if ! nc -w 1 -z "$n" 22 &>/dev/null; then
      echo "注意，無法連線 $n !" && exit 1
    fi
  done
  echo "DT 內網 ok!"
;;
esac