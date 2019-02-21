#Rab Feb 20 17:50:59 WIB 2019
file="$1"
filedec="$1dec"
jam="${file:0:2}"
#echo $jam


to_change_low="`echo {a..z} | tr -d " "`"
to_change_up="`echo {A..Z} | tr -d " "`"
to_change_low="$to_change_low$to_change_low"
to_change_up="$to_change_up$to_change_up"

for (( i=0; i<26; i++)); do
    dec="$dec${to_change_low:$i-jam:1}"
done

for (( i=0; i<26; i++)); do
    dec="$dec${to_change_up:$i-jam:1}"
done

to_change="`echo {a..z} | tr -d " "``echo {A..Z} | tr -d " "`"

`tr $dec $to_change < "$file" > "$filedec"`