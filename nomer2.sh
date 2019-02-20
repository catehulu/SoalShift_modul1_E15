#!/bin/bash

echo "2.a" >> 1.txt
cat WA_Sales_Products_2012-14.csv| awk 'BEGIN {FS=","}{if($7==2012)arr[$1]+=$10}END{for(a in arr)print arr[a]","a}'| sort -rg | awk 'NR==1'|awk 'BEGIN{FS=","}{print $2}' >> 1.txt

echo "2.b" >> 1.txt
cat WA_Sales_Products_2012-14.csv| awk 'BEGIN {FS=","}{if($7==2012 && $1=="United States")print $1","$7","$4","$10}' | awk 'FS=","{arr[$3]+=$4} END {for(a in arr) print arr[a]","a}' | sort -rg |awk 'NR < 4' |awk 'BEGIN{FS=","}{print $2}' >> 1.txt

echo "2.c" >> 1.txt
cat WA_Sales_Products_2012-14.csv| awk 'BEGIN {FS=","}{if($7==2012 && $1=="United States" && ($4 == "Personal Accessories"|| $4=="Camping Equipment" || $4 =="Outdor Protection"))print $1","$7","$6","$10}' |  awk 'FS=","{arr[$3]+=$4} END {for(a in arr) print arr[a]","a}' | sort -rg|awk 'NR < 4' |awk 'BEGIN{FS=","}{print $2}' >> 1.txt
