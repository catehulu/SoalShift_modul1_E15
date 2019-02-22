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
   gate=0
  fi
done

password=`< /dev/urandom tr -dc a-z0-9 | head -c1 >> $check`

password=`< /dev/urandom tr -dc A-Za-z0-9 | head -c10 >> $check`

password=`< /dev/urandom tr -dc 0-9 | head -c1 >> $check`
