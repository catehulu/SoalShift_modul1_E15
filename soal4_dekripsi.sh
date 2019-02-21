chr() {
  [ "$1" -lt 256 ] || return 1
  printf "\\$(printf '%03o' "$1")"
}

ord() {
  LC_CTYPE=C printf '%d' "'$1"
}

#Rab Feb 20 17:50:59 WIB 2019
file="$1"
jam="${file:0:2}"
echo $jam

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
    let "num=num-jam"
    if [ $num -lt 1 ]
    then
      let "num=num+25"
    fi
    let "num=num+64"
    enc="$enc`chr $num`"
  #echo $num
  elif [ $num -ge 97 ] && [ $num -le 122 ]
  then
    let "num=num-96"
    let "num=num-jam"
    if [ $num -lt 1 ]
    then
      let "num=num+25"
    fi
    let "num=num+96"
    enc="$enc`chr $num`"
  fi
}

text=`cat "$file"`

for (( i=0; i<${#text}; i++)); do
  convert "${text:$i:1}"
done

`echo "$enc" > "$file"`
