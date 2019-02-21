#!/bin/bash

cat WA_Sales_Products_2012-14.csv| awk 'BEGIN {FS=","}{if($7==2012)arr[$1]+=$10}END{for(hasil in arr)print arr[haisl]","hasil}'| sort -rg | awk 'NR==1'|awk 'BEGIN{FS=","}{print $2}' >> soal2a.txt

negara=`cat soal2a.txt`

cat WA_Sales_Products_2012-14.csv| awk -v varn="$negara" 'BEGIN {FS=","}{if($7==2012 && $1==varn)arr[$4]+=$10}END{for(hasil in arr) print arr[hasil]","hasil}' | sort -rg |awk 'NR < 4' |awk 'BEGIN{FS=","}{print $2}' >> soal2b.txt

prline1=`cat soal2b.txt | awk NR==1`
prline2=`cat soal2b.txt | awk NR==2`
prline3=`cat soal2b.txt | awk NR==3`

cat WA_Sales_Products_2012-14.csv| awk -v varn="$negara" -v varp1="$prline1" -v varp2="$prline2" -v varp3="$prline3" 'BEGIN {FS=","}{if($7==2012 && $1==varn && ($4==varp1|| $4==varp2 || $4==varp3))print $10","$6}'|sort -rg|awk 'NR < 4' |awk 'BEGIN{FS=","}{print $2}' >> soal2c.txt
