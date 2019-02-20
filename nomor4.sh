chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")"
}

ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

#Rab Feb 20 17:50:59 WIB 2019
jam="`date +\"%H\"`"
menit="`date +\"%M\"`"
tanggal="`date +\"%d\"`"
bulan="`date +\"%m\"`"
tahun="`date +\"%Y\"`"

file="$jam:$menit $tanggal-$bulan-$tahun"
#echo $file

enc=""

convert() {
  num=`ord $1`
  #echo $num
  if [ $num -lt 65 ] || [ $num -gt 122 ]
  then
  enc="$enc$1"
  elif [ $num -ge 65 ] && [ $num -le 90 ]
  then
    let "num=num-64"
    let "num=num+jam"
    if [ $num -gt 25 ]
    then
      let "num=num-25"
    fi
    let "num=num+64"
    enc="$enc`chr $num`"
  #echo $num
  elif [ $num -ge 97 ] && [ $num -le 122 ]
  then
    let "num=num-96"
    let "num=num+jam"
    if [ $num -gt 25 ]
    then
      let "num=num-25"
    fi
    let "num=num+96"
    enc="$enc`chr $num`"
  fi
}

text=`tail /var/log/syslog`

for (( i=0; i<${#text}; i++)); do
  convert "${text:$i:1}"
done

`echo $enc >> "$file"`
