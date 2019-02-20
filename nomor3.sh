#!/bin/bash

gate=1
ptr=1
while [ $gate -eq 1 ]
do
  check="password$ptr.txt"
  #echo $check

  if [ -f $check ]
  then
   #echo "Berhasil!"
   let "ptr++"
  else
   #echo "Tidak!"
   number="${current:8:-4}"
   gate=0
  fi
done
count=1
password=`< /dev/urandom tr -dc a-z0-9 | head -c1 >> $check`
while [ $count -le 5 ]
do
password=`< /dev/urandom tr -dc A-Za-z0-9 | head -c2 >> $check`
let "count++"
done
password=`< /dev/urandom tr -dc 0-9 | head -c1 >> $check`
